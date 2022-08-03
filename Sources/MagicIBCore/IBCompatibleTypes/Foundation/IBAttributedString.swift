//
//  IBAttributedString.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

class IBAttributedString {
    var fragments = [Fragment]()
    
    init() {}
    
    func addFragment(_ content: String) {
        let fragment = Fragment(content)
        fragments.append(fragment)
    }
    
    func addColorAttributes(_ attributes: [String: String]) {
        fragments.last?.addColor(attributes: attributes)
    }
    
    func addFontAttributes(_ attributes: [String: String]) {
        fragments.last?.addFont(attributes: attributes)
    }
    
    func addParagraphStyle(_ attributes: [String: String]) {
        fragments.last?.addParagraphStyle(attributes: attributes)
    }
}

extension IBAttributedString {
    
    class Fragment: IBCompatibleObject {
        var properties: [IBPropertyMapper] {
            [
                .init(propertyName: "content", type: .string),
                .init(ib: "NSBackgroundColor", propertyName: "backgroundColor", type: .color),
                .init(ib: "NSColor", propertyName: "foregroundColor", type: .color),
                .init(ib: "NSFont", propertyName: "font", type: .font),
                .init(ib: "NSParagraphStyle", propertyName: "paragraphStyle", type: .paragraphStyle)
            ]
        }
        
        init(_ content: String) {
            addValueToProperty(ib: "content", value: content)
        }
        
        func addParagraphStyle(attributes: [String: String]) {
            guard let ib = attributes["key"] else { return }
            let paragraphStyle = IBParagraphStyle(attributes: attributes)
            addValueToProperty(ib: ib, value: paragraphStyle)
        }
        
        func addColor(attributes: [String: String]) {
            guard let ib = attributes["key"],
                  let color = IBColor(attributes: attributes)
            else { return }
            addValueToProperty(ib: ib, value: color)
        }
        
        func addFont(attributes: [String: String]) {
            guard let ib = attributes["key"],
                  let font = IBFont(attributes: attributes)
            else { return }
            addValueToProperty(ib: ib, value: font)
        }
    }
    
}
