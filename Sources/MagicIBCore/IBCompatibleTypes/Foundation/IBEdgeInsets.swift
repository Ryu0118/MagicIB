//
//  IBEdgeInsets.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

@dynamicMemberLookup
struct IBEdgeInsets: IBCompatibleObject {
    let properties: [IBPropertyMapper] =
    [
        .init(propertyName: "top", type: .number),
        .init(propertyName: "leading", type: .number),
        .init(propertyName: "bottom", type: .number),
        .init(propertyName: "trailing", type: .number),
        .init(ib: "minY", propertyName: "top", type: .number),
        .init(ib: "maxY", propertyName: "bottom", type: .number),
        .init(ib: "minX", propertyName: "left", type: .number),
        .init(ib: "maxX", propertyName: "right", type: .number),
    ]
    
    init?(attributes: [String: String]) {
        mapping(attributes)
        if activatedProperties.count != 4 {
            return nil
        }
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
