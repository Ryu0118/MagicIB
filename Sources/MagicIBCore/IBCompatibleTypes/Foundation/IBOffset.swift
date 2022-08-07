//
//  IBOffset.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

@dynamicMemberLookup
struct IBOffset: IBCompatibleObject {
    let properties: [IBPropertyMapper] = [
        .init(propertyName: "horizontal", type: .number),
        .init(propertyName: "vertical", type: .number),
    ]
    
    init?(attributes: [String: String]) {
        mapping(attributes)
        if !isAllPropertiesActivated { return nil }
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
