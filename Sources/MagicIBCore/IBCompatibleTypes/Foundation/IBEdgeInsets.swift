//
//  IBEdgeInsets.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

struct IBEdgeInsets: IBCompatibleObject {
    var properties: [IBPropertyMapper] {
        [
            .init(propertyName: "top", type: .number),
            .init(propertyName: "leading", type: .number),
            .init(propertyName: "bottom", type: .number),
            .init(propertyName: "trailing", type: .number),
        ]
    }
    init?(attributes: [String: String]) {
        mapping(attributes)
        if !isAllPropertiesValid { return nil }
    }
}
