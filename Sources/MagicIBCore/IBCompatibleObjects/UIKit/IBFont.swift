//
//  IBFont.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBFont {
    enum FontType: String {
        case system
        case italicSystem
        case boldSystem
    }
    
    private(set) var size: String?
    private(set) var fontName: String?
    private(set) var fontFamily: String?
    private(set) var style: String?
    private(set) var type: FontType?
    
    init?(attributes: [String: String]) {
        if let size = attributes["size"] {
            self.size = size
        }
        if let size = attributes["pointSize"] {
            self.size = size
        }
        if let typeString = attributes["type"],
           let type = FontType(rawValue: typeString) {
            self.type = type
        }
        if let typeString = attributes["metaFont"],
           let type = FontType(rawValue: typeString) {
            self.type = type
        }
        if let style = attributes["style"] {
            self.style = style
        }
        if let fontName = attributes["name"] {
            self.fontName = fontName
        }
        if let fontFamily = attributes["family"] {
            self.fontFamily = fontFamily
        }
    }
}
