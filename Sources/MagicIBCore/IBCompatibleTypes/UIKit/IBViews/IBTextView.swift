//
//  IBTextView.swift
//  
//
//  Created by Ryu on 2022/08/07.
//
import Foundation

@dynamicMemberLookup
class IBTextView: IBScrollView {
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
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + textViewProperties
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
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
        default:
            break
        }
    }
}
