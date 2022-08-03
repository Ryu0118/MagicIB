//
//  IBImageSymbolConfiguration.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

struct IBImageSymbolConfiguration: IBCompatibleObject {
    var properties: [IBPropertyMapper] {
        [
            .init(propertyName: "configurationType", type: .enum),
            .init(propertyName: "pointSize", type: .number),
            .init(propertyName: "scale", type: .enum),
            .init(propertyName: "weight", type: .enum),
        ]
    }
    
    init(attributes: [String: String]) {
        mapping(attributes)
    }
}
