//
//  IBActivityIndicatorView.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

@dynamicMemberLookup
class IBActivityIndicatorView: IBView {
    private let activityIndicatorProperties: [IBPropertyMapper] = [
        .init(propertyName: "hidesWhenStopped", type: .bool),
        .init(ib: "animating", propertyName: "isAnimating", type: .bool),
        .init(propertyName: "style", type: .bool),
        .init(propertyName: "color", type: .color)
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + activityIndicatorProperties
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
