//
//  IBColor.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation
import OpenGL

struct IBColor: IBCompatibleObject {
    let properties: [IBPropertyMapper] =
    [
        .init(propertyName: "red", type: .number),
        .init(propertyName: "green", type: .number),
        .init(propertyName: "blue", type: .number),
        .init(propertyName: "alpha", type: .number),
        .init(propertyName: "systemColor", type: .string),
        .init(propertyName: "name", type: .string),
    ]
    
    
    init?(attributes: [String: String]) {
        mapping(attributes)
    }
}
