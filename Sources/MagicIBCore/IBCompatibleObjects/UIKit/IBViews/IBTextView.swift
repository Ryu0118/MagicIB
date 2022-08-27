//
//  IBTextView.swift
//  
//
//  Created by Ryu on 2022/08/07.
//
import Foundation

class IBTextView: IBScrollView, LongCharactersContainable {
    private let textViewProperties: [IBPropertyMapper] = [
        .init(propertyName: "text", type: .string),
        .init(propertyName: "textColor", type: .color),
        .init(propertyName: "fontDescription", type: .font),
        .init(propertyName: "autocapitalizationType", type: .enum),
        .init(propertyName: "autocorrectionType", type: .enum),
        .init(propertyName: "spellCheckingType", type: .enum),
        .init(propertyName: "keyboardType", type: .enum),
        .init(propertyName: "keyboardAppearance", type: .enum),
        .init(propertyName: "returnKeyType", type: .enum),
        .init(propertyName: "enablesReturnKeyAutomatically", type: .bool),
        .init(propertyName: "secureTextEntry", type: .bool),
        .init(propertyName: "smartDashesType", type: .enum),
        .init(propertyName: "smartInsertDeleteType", type: .enum),
        .init(propertyName: "smartQuotesType", type: .enum),
        .init(propertyName: "textContentType", type: .enum),
        .init(propertyName: "dataDetectorTypes", type: .optionSet),
        .init(propertyName: "attributedText", type: .attributedString),
    ]
    
    private var attributedString: IBAttributedString?
    
    override var properties: [IBPropertyMapper] {
        super.properties + textViewProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        
        switch elementTree {
        case "textInputTraits":
            mapping(attributes)
        case "dataDetectorType":
            guard let propertyName = attributes["key"],
                  let optionSet = IBOptionSet(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: optionSet)
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
        guard let key = key else { return }
        if key == "content" {
            attributedString?.addFragment(characters)
        }
        else if key == "text" {
            if let text = self.text as? String {
                addValueToProperty(ib: "text", value: text + characters)
            }
            else {
                addValueToProperty(ib: "text", value: characters)
            }
        }
    }
}
