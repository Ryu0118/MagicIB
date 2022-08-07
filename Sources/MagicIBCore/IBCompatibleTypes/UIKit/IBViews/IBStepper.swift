//
//  IBStepper.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

@dynamicMemberLookup
class IBStepper: IBView {
    private let stepperProperties: [IBPropertyMapper] = [
        .init(propertyName: "showsMenuAsPrimaryAction", type: .bool),
        .init(ib: "selected", propertyName: "isSelected", type: .bool),
        .init(propertyName: "contentHorizontalAlignment", type: .enum),
        .init(propertyName: "contentVerticalAlignment", type: .enum),
        .init(propertyName: "wraps", type: .bool),
        .init(propertyName: "value", type: .number),
        .init(propertyName: "minimumValue", type: .number),
        .init(propertyName: "maximumValue", type: .number),
        .init(propertyName: "stepValue", type: .number),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + stepperProperties
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
