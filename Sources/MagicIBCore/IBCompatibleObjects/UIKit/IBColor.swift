//
//  IBColor.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation
import OpenGL

@dynamicMemberLookup
struct IBColor: IBCompatibleObject {
    let properties: [IBPropertyMapper] =
    [
        .init(propertyName: "red", type: .number),
        .init(propertyName: "green", type: .number),
        .init(propertyName: "blue", type: .number),
        .init(propertyName: "alpha", type: .number),
        .init(propertyName: "systemColor", type: .enum),
        .init(propertyName: "name", type: .string),
    ]
    
    init?(attributes: [String: String]) {
        mapping(attributes)
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
