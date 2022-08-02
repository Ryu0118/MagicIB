//
//  IBAttributedString.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBAttributedString {
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
}

extension IBAttributedString {
    
    struct Fragment: IBCompatibleObject {
        var properties: [IBPropertyMapper] {
            [
                .init(propertyName: "content", type: .string),
                .init(ib: "NSBackgroundColor", propertyName: "backgroundColor", type: .color),
                .init(ib: "NSColor", propertyName: "foregroundColor", type: .color),
                .init(ib: "NSFont", propertyName: "font", type: .font),
            ]
        }
        
        init(_ content: String) {
            addValueToProperty(ib: "content", value: content)
        }
        
        mutating func addColor(attributes: [String: String]) {
            if let ib = attributes["key"] {
                let color = IBColor(attributes: attributes)
                addValueToProperty(ib: ib, value: color)
            }
        }
        
        mutating func addFont(attributes: [String: String]) {
            if let ib = attributes["key"] {
                let color = IBColor(attributes: attributes)
                addValueToProperty(ib: ib, value: color)
            }
        }
    }
    
}
