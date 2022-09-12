//
//  IBParser.swift
//  
//
//  Created by Ryu on 2022/07/28.
//

import CoreGraphics
import Foundation

public class IBParser: NSObject {
    
    var url: URL!
    var type: IBType!
    
    private var waitingIBViewList = [IBView]()
    private var waitingElementList = [String]()
    private var subviewFlags = [IBView]()
    private var prototypesFlag: IBTableView?
    private var cellFlag: IBCollectionView?
    private var parentView: IBView?
    private var lastAttributes: [String: String] = [:]
    private var gestureTypes = [IBGestureType]()
    private var completion: ((String?) -> ())?
    private var ibViewControllers = [IBViewController]() {
        didSet {
            parentView = nil
        }
    }
    
    public func parse(_ absoluteURL: URL, completion: @escaping (String?) -> ()) throws {
        self.type = try IBType(url: absoluteURL)
        self.completion = completion
        self.url = absoluteURL
        let data = try Data(contentsOf: absoluteURL)
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
}

// MARK: XMLParserDelegate
extension IBParser: XMLParserDelegate {
    
    public func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        waitingElementList.append(elementName)
        lastAttributes = attributeDict
        
        if let ibViewElement = IBCompatibleViewType.init(rawValue: elementName),
           let ibView = IBView.instance(attributes: attributeDict, ibCompatibleView: ibViewElement)
        {
            parseIBView(ibView: ibView, attributeDict: attributeDict)
        }
        else if let ibCompatibleViewController: IBCompatibleViewController = .init(rawValue: elementName),
                let ibViewController = IBViewController(attributes: attributeDict, ibCompatibleViewController: ibCompatibleViewController)
        {
            ibViewControllers.append(ibViewController)
        }
        else {
            handleNonInspectableElement(elementName: elementName, attributeDict: attributeDict)
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let anyView = waitingIBViewList.last as? LongCharactersContainable,
              !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else { return }
        
        anyView.handleLongCharacters(key: lastAttributes["key"], characters: string)
    }
    
    public func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        
        if let lastIndex = waitingIBViewList.lastIndex(where: { $0.classType.rawValue == elementName }) {
            waitingIBViewList.remove(at: lastIndex)
        }
        
        if let lastIndex = waitingElementList.lastIndex(of: elementName) {
            waitingElementList.remove(at: lastIndex)
            waitingIBViewList.last?.waitingElementList = waitingElementList
        }
        
        resetFlagsIfNeeded(elementName: elementName)
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        setGestureType()
        completion?(generateSwiftCode())
    }
    
}

//MARK: private extension
private extension IBParser {
    
    func handleNonInspectableElement(elementName: String, attributeDict: [String: String]) {
        guard let lastIBView = waitingIBViewList.last else {
            if let gestureType = IBGestureType(elementName: elementName, attributes: attributeDict) {
                gestureTypes.append(gestureType)
            }
            return
        }
        
        switch elementName {
        case "subviews":
            subviewFlags.append(lastIBView)
            if parentView == nil {
                parentView = lastIBView
                parentView?.uniqueName = type == .storyboard ? "view" : "self"
            }
        case "prototypes":
            prototypesFlag = lastIBView as? IBTableView
        case "cells":
            cellFlag = lastIBView as? IBCollectionView
        default:
            lastIBView.waitingElementList = waitingElementList
            lastIBView.addValueToProperties(attributes: attributeDict)
        }
    }
    
    func parseIBView(ibView: IBView, attributeDict: [String: String]) {
        waitingIBViewList.append(ibView)
        
        if ibViewControllers.last?.ibView == nil {
            ibViewControllers.last?.ibView = ibView
        }
        
        if let tableView = prototypesFlag,
           let cell = ibView as? IBTableViewCell {
            tableView.prototypes.append(cell)
        }
        else if let parentView = subviewFlags.last {
            handleSubviewFlag(ibView: ibView, parentView: parentView, attributeDict: attributeDict)
        }
        else if let collectionView = cellFlag,
                let cell = ibView as? IBCollectionViewCell
        {
            collectionView.cells.append(cell)
        }
    }
    
    func handleSubviewFlag(ibView: IBView, parentView: IBView, attributeDict: [String: String]) {
        if let stackView = parentView as? IBStackView {
            stackView.arrangedSubviews.append(ibView)
        }
        else if attributeDict["key"] == nil {
            parentView.subviews.append(ibView)
        }
        else if let propertyName = attributeDict["key"] {
            guard let previousIBView = waitingIBViewList[safe: waitingIBViewList.count - 2] else { return }
            previousIBView.addValueToProperty(ib: propertyName, value: ibView)
        }
    }
    
    func generateSwiftCode() -> String? {
        if type == .storyboard {
            let generator = SwiftGenerator(url: url, type: .storyboard(ibViewControllers: ibViewControllers))
            let string = generator.generate()
            return string
        }
        else {
            guard let ibView = parentView else { return nil }
            let generator = SwiftGenerator(url: url, type: .xib(ibView: ibView))
            let string = generator.generate()
            return string
        }
    }
    
    func setGestureType() {
        let gestureRecognizers = ibViewControllers.findAllSubviews().flatMap { $0.gestures }
        for gestureRecognizer in gestureRecognizers {
            for gestureType in gestureTypes {
                if gestureRecognizer.destination == gestureType.id {
                    gestureRecognizer.gestureType = gestureType
                }
            }
        }
    }
    
    func resetFlagsIfNeeded(elementName: String) {
        switch elementName {
        case "subviews":
            subviewFlags.removeLast()
        case "prototypes":
            prototypesFlag = nil
        case "cells":
            cellFlag = nil
        default:
            break
        }
    }
}

// MARK: Enum
extension IBParser {
    
    enum IBParserError: LocalizedError {
        case invalidExtension
        
        public var errorDescription: String? {
            switch self {
            case .invalidExtension:
                return "File extensions must be xib and storyboard"
            }
        }
    }
    
    enum IBType: String {
        case storyboard
        case xib
        
        init(url: URL) throws {
            let ext = url.pathExtension.lowercased()
            guard let type = IBType(rawValue: ext) else { throw IBParserError.invalidExtension }
            self = type
        }
    }
    
}
 
private extension Array where Element == IBViewController {
    
    func findAllSubviews() -> [IBView] {
        self.flatMap {
            $0.ibView.subviews.findAllSubviews() + [$0.ibView].compactMap { $0 }
        }
    }
    
}
