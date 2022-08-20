//
//  IBSize.swift
//  
//
//  Created by Ryu on 2022/08/04.
//

import Foundation

@dynamicMemberLookup
struct IBSize: IBCompatibleObject {
    let properties: [IBPropertyMapper] = [
        .init(propertyName: "width", type: .number),
        .init(propertyName: "height", type: .number),
    ]
    
    init?(attributes: [String: String]) {
        mapping(attributes)
        if !isAllPropertiesActivated { return nil }
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
