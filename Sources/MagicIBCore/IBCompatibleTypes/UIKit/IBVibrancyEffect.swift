//
//  IBVibrancyEffect.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

struct IBVibrancyEffect: IBCompatibleObject {
    let properties: [IBPropertyMapper] = [
        .init(propertyName: "blurEffect", type: .visualEffect),
        .init(propertyName: "style", type: .enum)
    ]
    init(attributes: [String: String]) {
        mapping(attributes)
    }
}
