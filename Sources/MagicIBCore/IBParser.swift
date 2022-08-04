//
//  IBParser.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import CoreGraphics
import Foundation

public class IBParser: NSObject {

    fileprivate var type: IBType?
    private var waitingIBViewList = [IBView]()
    private var waitingElementList = [String]()
    private var ibViewControllers = [IBViewController]()
    private var subviewsFlags = [IBView]()
    private var parentView: IBView?
    private(set) var parentViews = [IBView]()
    
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
            if let parentView = subviewsFlags.last {
                parentView.subviews.append(ibView)
            }
        }
        else if let ibCompatibleViewController: IBCompatibleViewController = .init(rawValue: elementName),
                let ibViewController = IBViewController(attributes: attributeDict, ibCompatibleViewController: ibCompatibleViewController)
        {
            ibViewControllers.append(ibViewController)
        }
        else {
            guard let lastIBView = waitingIBViewList.last else { return }
            if elementName == "subviews" {
                subviewsFlags.append(lastIBView)
                if parentView == nil { parentView = lastIBView }
            }
            else {
                IBView.addValueToProperties(ibView: lastIBView, elementName: elementName, waitingElementList: waitingElementList, attributes: attributeDict)
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
        if elementName == "subviews" {
            subviewsFlags.removeLast()
        }
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        
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
#endif 
