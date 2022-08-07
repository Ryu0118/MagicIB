//
//  IBScrollView.swift
//  
//
//  Created by Ryu on 2022/08/05.
//

import Foundation

@dynamicMemberLookup
class IBScrollView: IBView {
    private let scrollViewProperties: [IBPropertyMapper] = [
        .init(ib: "directionalLockEnabled", propertyName: "isDirectionalLockEnabled", type: .bool),
        .init(propertyName: "preservesSuperviewLayoutMargins", type: .bool),
        .init(propertyName: "alwaysBounceVertical", type: .bool),
        .init(propertyName: "alwaysBounceHorizontal", type: .bool),
        .init(ib: "pagingEnabled", propertyName: "isPagingEnabled", type: .bool),
        .init(propertyName: "contentInsetAdjustmentBehavior", type: .enum),
        .init(propertyName: "indicatorStyle", type: .enum),
        .init(propertyName: "minimumZoomScale", type: .number),
        .init(propertyName: "maximumZoomScale", type: .number),
        .init(propertyName: "keyboardDismissMode", type: .enum),
        .init(propertyName: "directionalLayoutMargins", type: .edgeInsets),
        .init(propertyName: "scrollIndicatorInsets", type: .edgeInsets),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + scrollViewProperties
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        switch elementTree {
        case "directionalEdgeInsets":
            guard let propertyName = attributes["key"],
                  let edgeInsets = IBEdgeInsets(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: edgeInsets)
        case "inset":
            guard let propertyName = attributes["key"],
                  let edgeInsets = IBEdgeInsets(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: edgeInsets)
        default:
            break
        }
    }
    
}
