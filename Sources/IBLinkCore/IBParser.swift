//
//  File.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import CoreGraphics
import Foundation

public class IBParser: NSObject {

    fileprivate var type: IBType?
    private var waitingIBViewList = [String]()
    private var ibViewControllers = [IBViewController]()
    
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
        if let ibViewElement = IBViewCompatibleElement.init(rawValue: elementName),
           let ibView = IBView(attributes: attributeDict, ibViewCompatibleElement: ibViewElement)
        {
            waitingIBViewList.append(elementName)
            ibViewControllers.last?.appendView(ibView)
        }
        else if let ibViewControllerElement = IBViewControllerCompatibleElement.init(rawValue: elementName),
                let ibViewController = IBViewController(attributes: attributeDict, ibViewControllerElement: ibViewControllerElement) {
            print(ibViewController.typeName)
            ibViewControllers.append(ibViewController)
        }
        else {
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let lastIndex = waitingIBViewList.lastIndex(of: elementName) {
            waitingIBViewList.remove(at: lastIndex)
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
