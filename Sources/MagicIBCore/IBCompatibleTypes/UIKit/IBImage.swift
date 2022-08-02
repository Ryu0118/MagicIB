//
//  IBImage.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBImage: IBCompatibleObject {
    var properties: [IBPropertyMapper] {
        [
            .init(propertyName: "systemName", type: .string),
            .init(propertyName: "name", type: .string)
        ]
    }
    
    init?(attributes: [String: String]) {
        guard let image = attributes["image"] else { return nil }
        if let _ = attributes["catalog"] {
            addValueToProperty(ib: "systemName", value: image)
        }
        else {
            addValueToProperty(ib: "name", value: image)
        }
    }
}

