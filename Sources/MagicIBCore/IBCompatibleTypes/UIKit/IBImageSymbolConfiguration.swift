//
//  IBImageSymbolConfiguration.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

@dynamicMemberLookup
struct IBImageSymbolConfiguration: IBCompatibleObject {
    let properties: [IBPropertyMapper] =
    [
        .init(propertyName: "configurationType", type: .enum),
        .init(propertyName: "pointSize", type: .number),
        .init(propertyName: "scale", type: .enum),
        .init(propertyName: "weight", type: .enum),
    ]
    
    
    init(attributes: [String: String]) {
        mapping(attributes)
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
