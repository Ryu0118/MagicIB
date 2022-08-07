//
//  IBBlurEffect.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

struct IBBlurEffect: IBCompatibleObject {
    let properties: [IBPropertyMapper] = [
        .init(propertyName: "style", type: .enum)
    ]
    init(attributes: [String: String]) {
        mapping(attributes)
    }
}
