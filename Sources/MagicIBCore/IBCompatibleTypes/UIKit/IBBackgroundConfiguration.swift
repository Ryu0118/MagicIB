//
//  IBBackgroundConfiguration.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

@dynamicMemberLookup
struct IBBackgroundConfiguration: IBCompatibleObject {
    let properties: [IBPropertyMapper] =
    [
        .init(propertyName: "image", type: .image),
        .init(propertyName: "imageContentMode", type: .enum),
        .init(propertyName: "strokeWidth", type: .number),
        .init(propertyName: "strokeOffset", type: .number),
        .init(propertyName: "strokeColor", type: .color),
        .init(propertyName: "backgroundColor", type: .color),
        .init(propertyName: "cornerRadius", type: .number),
    ]
    
    init?(attributes: [String: String]) {
        if let _ = attributes["image"] {
            guard let image = IBImage(attributes: attributes) else { return nil }
            addValueToProperty(ib: "image", value: image)
        }
        let attributes = attributes.filter{ key, value in key != "image" }
        mapping(attributes)
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
