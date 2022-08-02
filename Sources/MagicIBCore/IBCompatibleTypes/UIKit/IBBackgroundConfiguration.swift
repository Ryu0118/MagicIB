//
//  IBBackgroundConfiguration.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBBackgroundConfiguration: IBCompatibleObject {
    var properties: [IBPropertyMapper] {
        [
            .init(propertyName: "image", type: .image),
            .init(propertyName: "imageContentMode", type: .enum),
            .init(propertyName: "strokeWidth", type: .number),
            .init(propertyName: "strokeOffset", type: .number),
        ]
    }
    init(attributes: [String: String]) {
        if let _ = attributes["image"] {
            let image = IBImage(attributes: attributes)
            addValueToProperty(ib: "image", value: image)
        }
        let attributes = attributes.filter{ key, value in key != "image" }
        mapping(attributes)
    }
}
