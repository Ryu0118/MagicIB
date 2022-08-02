//
//  IBParagraphStyle.swift
//  
//
//  Created by Ryu on 2022/08/02.
//

import Foundation

struct IBParagraphStyle: IBCompatibleObject {
    
    var properties: [IBPropertyMapper] {
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
            .init(propertyName: "tighteningFactorForTruncation", type: .number),
            .init(propertyName: "headerLevel", type: .number),
        ]
    }
    
    init(_ attributes: [String: String]) {
        mapping(attributes: attributes)
    }
    
}
