//
//  IBTextView.swift
//  
//
//  Created by Ryu on 2022/08/07.
//
import Foundation

struct IBOptionSet {
    private(set) var set = Set<String>()
    func add(_ element: String) {
        set.insert(element)
    }
}

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
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + textViewProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        
        switch elementTree {
            
        }
    }
}
/*
 
 <textInputTraits key="textInputTraits" autocapitalizationType="sentences" autocorrectionType="no" spellCheckingType="yes" keyboardType="numbersAndPunctuation" keyboardAppearance="alert" returnKeyType="route" enablesReturnKeyAutomatically="YES" secureTextEntry="YES" smartDashesType="no" smartInsertDeleteType="yes" smartQuotesType="yes" textContentType="address-level2"/>
 */
