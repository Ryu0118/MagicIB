//
//  IBProgressView.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

class IBProgressView: IBView {
    private let progressProperties: [IBPropertyMapper] = [
        .init(propertyName: "semanticContentAttribute", type: .enum),
        .init(propertyName: "progress", type: .number),
        .init(propertyName: "progressViewStyle", type: .enum),
        .init(propertyName: "progressImage", type: .image),
        .init(propertyName: "trackImage", type: .image),
        .init(propertyName: "progressTintColor", type: .color),
        .init(propertyName: "trackTintColor", type: .color),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + progressProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
    }
    
}
