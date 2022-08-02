//
//  IBRect.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBRect: IBCompatibleObject {
    var properties: [IBPropertyMapper] {
        [
            .init(propertyName: "x", type: .number),
            .init(propertyName: "y", type: .number),
            .init(propertyName: "width", type: .number),
            .init(propertyName: "height", type: .number),
        ]
    }
    
    init?(attributes: [String: String]) {
        mapping(attributes)
        if !isAllPropertiesValid { return nil }
    }
}
