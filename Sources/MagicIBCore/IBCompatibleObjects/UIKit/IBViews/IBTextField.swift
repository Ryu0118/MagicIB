//
//  IBTextField.swift
//  
//
//  Created by Ryu on 2022/09/09.
//

import Foundation

class IBTextField: IBView, LongCharactersContainable {
    
    private let textFieldProperties: [IBPropertyMapper] = [
        .init(propertyName: "borderStyle", type: .enum),
        .init(propertyName: "text", type: .string),
        .init(propertyName: "placeholder", type: .string),
        .init(propertyName: "clearsOnBeginEditing", type: .bool),
        .init(propertyName: "minimumFontSize", type: .number),
        .init(propertyName: "clearButtonMode", type: .enum),
        .init(propertyName: "attributedText", type: .attributedString),
        .init(propertyName: "autocapitalizationType", type: .enum),
        .init(propertyName: "autocorrectionType", type: .enum),
        .init(propertyName: "keyboardType", type: .enum),
        .init(propertyName: "keyboardAppearance", type: .enum),
        .init(propertyName: "returnKeyType", type: .enum),
        .init(propertyName: "enablesReturnKeyAutomatically", type: .bool),
        .init(ib: "isSecureTextEntry", propertyName: "secureTextEntry", type: .bool),
        .init(propertyName: "smartDashesType", type: .enum),
        .init(propertyName: "smartInsertDeleteType", type: .enum),
        .init(propertyName: "smartQuotesType", type: .enum),
        .init(propertyName: "textContentType", type: .enum),
        .init(propertyName: "background", type: .image),
        .init(propertyName: "disabledBackground", type: .image),
    ]
    
    private var attributedString: IBAttributedString?
    
    override var properties: [IBPropertyMapper] {
        super.properties + textFieldProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        
        switch elementTree {
        case "textInputTraits":
            mapping(attributes)
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
        case "imageReference":
            guard let propertyName = attributes["key"],
                  let image = IBImage(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: image)
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
