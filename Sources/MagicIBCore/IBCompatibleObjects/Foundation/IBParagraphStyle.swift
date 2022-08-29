//
//  IBParagraphStyle.swift
//  
//
//  Created by Ryu on 2022/08/02.
//

import Foundation

@dynamicMemberLookup
class IBParagraphStyle: IBCompatibleObject, UniqueName {
    
    let properties: [IBPropertyMapper] =
    [
        .init(propertyName: "alignment", type: .enum),
        .init(propertyName: "lineBreakMode", type: .enum),
        .init(propertyName: "baseWritingDirection", type: .enum),
        .init(propertyName: "lineSpacing", type: .number),
        .init(propertyName: "paragraphSpacing", type: .number),
        .init(propertyName: "paragraphSpacingBefore", type: .number),
        .init(propertyName: "firstLineHeadIndent", type: .number),
        .init(propertyName: "lineHeightMultiple", type: .number),
        .init(propertyName: "headIndent", type: .number),
        .init(propertyName: "minimumLineHeight", type: .number),
        .init(propertyName: "maximumLineHeight", type: .number),
        .init(propertyName: "defaultTabInterval", type: .number),
        .init(propertyName: "hyphenationFactor", type: .number),
        .init(propertyName: "headerLevel", type: .number),
    ]
    
    var uniqueName: String?
    
    init(attributes: [String: String]) {
        mapping(attributes)
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
