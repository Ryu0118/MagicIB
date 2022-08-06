//
//  IBParser.swift
//  
//
//  Created by Ryu on 2022/07/28.
//

import CoreGraphics
import Foundation

public class IBParser: NSObject {

    fileprivate var type: IBType?
    private var waitingIBViewList = [IBView]()
    private var waitingElementList = [String]()
    private var ibViewControllers = [IBViewController]()
    private var subviewsFlags = [IBView]()
    private var prototypesFlag: IBTableView?
    private var cellFlag: IBCollectionView?
    private var parentView: IBView?
    
    public func parse(_ absoluteURL: URL) throws {
        self.type = try IBType(url: absoluteURL)
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
            ibViewControllers.last?.appendView(ibView)
            if let tableView = prototypesFlag,
               let cell = ibView as? IBTableViewCell {
                tableView.prototypes.append(cell)
            }
            else if let parentView = subviewsFlags.last {
                parentView.subviews.append(ibView)
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
                subviewsFlags.append(lastIBView)
                if parentView == nil { parentView = lastIBView }
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
            subviewsFlags.removeLast()
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
    
    fileprivate enum IBType: String {
        case storyboard
        case xib
        
        init(url: URL) throws {
            let ext = url.pathExtension.lowercased()
            guard let type = IBType(rawValue: ext) else { throw IBParserError.invalidExtension }
            self = type
        }
    }
    
}
 
