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
    private var ibViewControllers = [IBViewController]()
    private var subviewFlags = [IBView]()
    private var prototypesFlag: IBTableView?
    private var cellFlag: IBCollectionView?
    private var parentView: IBView?
    
    public func parse(_ absoluteURL: URL) throws {
        self.type = try IBType(url: absoluteURL)
        self.url = absoluteURL
        let data = try Data(contentsOf: absoluteURL)
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
}

// MARK: XMLParserDelegate
extension IBParser: XMLParserDelegate {
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        waitingElementList.append(elementName)

        if let ibViewElement = IBCompatibleView.init(rawValue: elementName),
           let ibView = IBView.instance(attributes: attributeDict, ibCompatibleView: ibViewElement)
        {
            waitingIBViewList.append(ibView)
            
            if ibViewControllers.last?.ibView == nil {
                ibViewControllers.last?.ibView = ibView
            }
            
            if let tableView = prototypesFlag,
               let cell = ibView as? IBTableViewCell {
                tableView.prototypes.append(cell)
            }
            else if let parentView = subviewFlags.last {
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
            else if let collectionView = cellFlag,
                    let cell = ibView as? IBCollectionViewCell
            {
                collectionView.cells.append(cell)
            }
        }
        else if let ibCompatibleViewController: IBCompatibleViewController = .init(rawValue: elementName),
                let ibViewController = IBViewController(attributes: attributeDict, ibCompatibleViewController: ibCompatibleViewController)
        {
            ibViewControllers.append(ibViewController)
        }
        else {
            guard let lastIBView = waitingIBViewList.last else { return }
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
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        if let textView = waitingIBViewList.last as? IBTextView {
            textView.addValueToProperty(ib: "text", value: string)
        }
        else if let label = waitingIBViewList.last as? IBLabel {
            if let text = label.text as? String {
                label.addValueToProperty(ib: "text", value: text + string)
            }
            else {
                label.addValueToProperty(ib: "text", value: string)
            }
        }
        else if let searchBar = waitingIBViewList.last as? IBSearchBar {
            if var array = searchBar.scopeButtonTitles as? [String] {
                array.append(string)
                searchBar.addValueToProperty(ib: "scopeButtonTitles", value: array)
            }
            else {
                let array = [string]
                searchBar.addValueToProperty(ib: "scopeButtonTitles", value: array)
            }
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if let lastIndex = waitingIBViewList.lastIndex(where: { $0.classType.rawValue == elementName }) {
            waitingIBViewList.remove(at: lastIndex)
        }
        if let lastIndex = waitingElementList.lastIndex(of: elementName) {
            waitingElementList.remove(at: lastIndex)
            waitingIBViewList.last?.waitingElementList = waitingElementList
        }
        
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
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        print("parse end")
        let generator = SwiftCodeGenerator(url: url, type: .storyboard(ibViewController: ibViewControllers.last!))
        let string = try! generator.generate()
        print(string)
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
 
