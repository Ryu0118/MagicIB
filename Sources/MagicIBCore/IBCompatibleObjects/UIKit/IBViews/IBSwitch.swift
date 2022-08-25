//
//  IBSwitch.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

class IBSwitch: IBView {
    private let switchProperties: [IBPropertyMapper] = [
        .init(propertyName: "showsMenuAsPrimaryAction", type: .bool),
        .init(ib: "selected", propertyName: "isSelected", type: .bool),
        .init(ib: "on", propertyName: "isOn", type: .bool),
        .init(propertyName: "contentHorizontalAlignment", type: .enum),
        .init(propertyName: "contentVerticalAlignment", type: .enum),
        .init(propertyName: "title", type: .string),
        .init(propertyName: "preferredStyle", type: .enum),
        .init(propertyName: "onTintColor", type: .color),
        .init(propertyName: "thumbTintColor", type: .color)
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + switchProperties
    }
}
