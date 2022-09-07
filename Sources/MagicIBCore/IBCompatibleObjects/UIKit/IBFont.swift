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
    
    private let styles = [
        "UICTFontTextStyleTitle0": "largeTitle",
        "UICTFontTextStyleTitle1": "title1",
        "UICTFontTextStyleTitle2": "title2",
        "UICTFontTextStyleTitle3": "title3",
        "UICTFontTextStyleHeadline": "headline",
        "UICTFontTextStyleSubhead": "subheadline",
        "UICTFontTextStyleBody": "body",
        "UICTFontTextStyleCallout": "callout",
        "UICTFontTextStyleFootnote": "footnote",
        "UICTFontTextStyleCaption1": "caption1",
        "UICTFontTextStyleCaption2": "caption2",
    ]
    
    private(set) var size: String?
    private(set) var fontName: String?
    private(set) var fontFamily: String?
    private(set) var type: FontType?
    private(set) var style: String?
    
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
            self.style = styles[style]
        }
        if let fontName = attributes["name"] {
            self.fontName = fontName
        }
        if let fontFamily = attributes["family"] {
            self.fontFamily = fontFamily
        }
    }
}
