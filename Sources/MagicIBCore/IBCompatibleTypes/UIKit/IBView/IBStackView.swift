//
//  IBStackView.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

class IBStackView: IBView {
    
    private let stackViewProperties: [IBPropertyMapper] = [
        .init(propertyName: "axis", type: .enum),
        .init(propertyName: "distribution", type: .enum),
        .init(propertyName: "alignment", type: .enum),
        .init(propertyName: "spacing", type: .number),
        .init(ib: "baselineRelativeArrangement", propertyName: "isBaselineRelativeArrangement", type: .enum),
    ]
    
    var arrangedSubviews = [IBView]()
    
    override var properties: [IBPropertyMapper] {
        super.properties + stackViewProperties
    }
    
}
