//
//  IBLabel.swift
//  
//
//  Created by Ryu on 2022/08/04.
//

import Foundation

final class IBLabel: IBView, LongCharactersContainable {
    private let labelProperties: [IBPropertyMapper] = [
        .init(propertyName: "numberOfLines", type: .number),
        .init(propertyName: "lineBreakMode", type: .enum),
        .init(propertyName: "baselineAdjustment", type: .enum),
        .init(propertyName: "minimumScaleFactor", type: .number),
        .init(propertyName: "showsExpansionTextWhenTruncated", type: .bool),
        .init(ib: "highlightedColor", propertyName: "highlightedTextColor", type: .color),
        .init(propertyName: "shadowColor", type: .color),
        .init(propertyName: "shadowOffset", type: .size),
        .init(propertyName: "attributedText", type: .attributedString),
        .init(ib: "adjustFontSizeToFit", propertyName: "adjustsFontSizeToFitWidth", type: .bool),
        .init(propertyName: "text", type: .string),
    ]
    
    private var attributedString: IBAttributedString?
    
    override var properties: [IBPropertyMapper] {
        super.properties + labelProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        switch elementTree {
        case "size":
            guard let propertyName = attributes["key"],
                  let size = IBSize(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: size)
        case "attributedString":
            guard let propertyName = attributes["key"] else { return }
            attributedString = IBAttributedString()
            attributedString?.uniqueName = propertyName
            addValueToProperty(ib: propertyName, value: attributedString!)
        case "attributedString->fragment":
            guard let content = attributes["content"] else { return }
            attributedString?.addFragment(content)
        case "attributedString->fragment->attributes->color":
            attributedString?.addColorAttributes(attributes)
        case "attributedString->fragment->attributes->font":
            attributedString?.addFontAttributes(attributes)
        case "attributedString->fragment->attributes->paragraphStyle":
            attributedString?.addParagraphStyle(attributes)
        default:
            break
        }
    }
    
    func handleLongCharacters(key: String?, characters: String) {
        if let text = self.text as? String {
            addValueToProperty(ib: "text", value: text + characters)
        }
        else {
            addValueToProperty(ib: "text", value: characters)
        }
    }
    
}
