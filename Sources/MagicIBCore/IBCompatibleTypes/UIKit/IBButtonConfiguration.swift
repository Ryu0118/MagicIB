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
        ]
    }
    init(attributes: [String: String]) {
        
    }
}
