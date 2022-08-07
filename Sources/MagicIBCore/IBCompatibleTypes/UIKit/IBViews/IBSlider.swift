//
//  IBSlider.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

@dynamicMemberLookup
class IBSlider: IBView {
    private let sliderProperties: [IBPropertyMapper] = [
        .init(ib: "selected", propertyName: "isSelected", type: .bool),
        .init(propertyName: "showsMenuAsPrimaryAction", type: .bool),
        .init(propertyName: "contentHorizontalAlignment", type: .enum),
        .init(propertyName: "contentVerticalAlignment", type: .enum),
        .init(propertyName: "value", type: .number),
        .init(ib: "minValue", propertyName: "minimumValue", type: .number),
        .init(ib: "maxValue", propertyName: "maximumValue", type: .number),
        .init(propertyName: "minimumValueImage", type: .image),
        .init(propertyName: "maximumValueImage", type: .image),
        .init(propertyName: "preferredBehavioralStyle", type: .enum),
        .init(propertyName: "minimumTrackTintColor", type: .color),
        .init(propertyName: "maximumTrackTintColor", type: .color),
        .init(propertyName: "thumbTintColor", type: .color),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + sliderProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
