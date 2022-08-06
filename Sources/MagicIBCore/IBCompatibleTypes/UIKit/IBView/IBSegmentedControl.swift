//
//  IBSegmentedControl.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

class IBSegmentedControl: IBView {
    
    private let segmentedControlProperties: [IBPropertyMapper] = [
        .init(propertyName: "semanticContentAttribute", type: .enum),
        .init(ib: "showsMenuAsPrimaryAction", propertyName: "showsMenuAsPrimaryAction", type: .bool),
        .init(propertyName: "contentHorizontalAlignment", type: .enum),
        .init(propertyName: "contentVerticalAlignment", type: .enum),
        .init(propertyName: "selectedSegmentIndex", type: .number),
        .init(ib: "momentary", propertyName: "isMomentary", type: .bool),
        .init(ib: "springLoaded", propertyName: "isSpringLoaded", type: .bool),
        .init(propertyName: "selectedSegmentTintColor", type: .color)
    ]
    
    private let segmentedControlFunctions: [IBFunctionMapper] = [
        .init(ib: "title", functionName: "setTitle", argumentNames: ["", "forSegmentAt"]),
        .init(ib: "image", functionName: "setImage", argumentNames: ["", "forSegmentAt"])
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + segmentedControlProperties
    }
}
