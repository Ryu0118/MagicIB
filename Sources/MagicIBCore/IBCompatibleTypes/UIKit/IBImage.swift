//
//  IBImage.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBImage: IBCompatibleObject {
    let properties: [IBPropertyMapper] =
    [
        .init(propertyName: "systemName", type: .string),
        .init(propertyName: "name", type: .string),
        .init(propertyName: "symbolScale", type: .enum),
        .init(propertyName: "renderingMode", type: .enum),
    ]
    
    
    init?(attributes: [String: String]) {
        guard let image = attributes["image"] else { return nil }
        mapping(attributes)
        if let _ = attributes["catalog"] {
            addValueToProperty(ib: "systemName", value: image)
        }
        else {
            addValueToProperty(ib: "name", value: image)
        }
    }
    
    init(imageName: String) {
        addValueToProperty(ib: "name", value: <#T##Any#>)
    }
}

