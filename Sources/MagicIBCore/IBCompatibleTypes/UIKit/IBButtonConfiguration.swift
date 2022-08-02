//
//  IBButtonConfiguration.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBButtonConfiguration: IBCompatibleObject {
    
    var properties: [IBPropertyMapper] {
        [
            .init(propertyName: "style", type: .enum),
            .init(propertyName: "image", type: .image),
            .init(propertyName: "imagePlacement", type: .enum),
            .init(propertyName: "imagePadding", type: .number),
            .init(propertyName: "title", type: .string),
            .init(propertyName: "titlePadding", type: .number),
            .init(propertyName: "cornerStyle", type: .enum),
            .init(propertyName: "showsActivityIndicator", type: .bool),
            .init(propertyName: "background", type: .backgroundConfiguration),
            .init(propertyName: "preferredSymbolConfigurationForImage", type: .symbolConfiguration),
            .init(propertyName: "attributedTitle", type: .attributedString),
            .init(propertyName: "attributedSubtitle", type: .attributedString),
            .init(propertyName: "contentInsets", type: .edgeInsets),
            .init(propertyName: "baseForegroundColor", type: .color),
            .init(propertyName: "baseBackgroundColor", type: .color),
        ]
    }
    
    init(attributes: [String: String]) {
        mapping(attributes)
    }
    
}
