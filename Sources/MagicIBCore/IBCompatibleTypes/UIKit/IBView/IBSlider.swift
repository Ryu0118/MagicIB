//
//  IBSlider.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

class IBSlider: IBView {
    private let sliderProperties: [IBPropertyMapper] = [
        .init(ib: "selected", propertyName: "isSelected", type: .bool),
        .init(propertyName: "showsMenuAsPrimaryAction", type: .bool),
        .init(propertyName: "contentHorizontalAlignment", type: .enum),
        .init(propertyName: "contentVerticalAlignment", type: .enum),
        .init(propertyName: "value", type: .number),
        .init(ib: "minValue", propertyName: "minimumValue", type: .number),
        .init(ib: "maxValue", propertyName: "maximumValue", type: .number),
        .init(propertyName: "minimumValueImage", type: <#T##IBInspectableType#>)
    ]
}
 
