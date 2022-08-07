//
//  IBBlurEffect.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

@dynamicMemberLookup
struct IBBlurEffect: IBCompatibleObject {
    let properties: [IBPropertyMapper] = [
        .init(propertyName: "style", type: .enum)
    ]
    
    init(attributes: [String: String]) {
        mapping(attributes)
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
