//
//  IBPageControl.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

@dynamicMemberLookup
class IBPageControl: IBView {
    private let pageControlProperties: [IBPropertyMapper] = [
        .init(propertyName: "showsMenuAsPrimaryAction", type: .bool),
        .init(ib: "selected", propertyName: "isSelected", type: .bool),
        .init(propertyName: "contentHorizontalAlignment", type: .enum),
        .init(propertyName: "contentVerticalAlignment", type: .enum),
        .init(propertyName: "hidesForSinglePage", type: .bool),
        .init(propertyName: "defersCurrentPageDisplay", type: .bool),
        .init(propertyName: "numberOfPages", type: .number),
        .init(propertyName: "currentPage", type: .number),
        .init(propertyName: "pageIndicatorTintColor", type: .color),
        .init(propertyName: "currentPageIndicatorTintColor", type: .color),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + pageControlProperties
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
