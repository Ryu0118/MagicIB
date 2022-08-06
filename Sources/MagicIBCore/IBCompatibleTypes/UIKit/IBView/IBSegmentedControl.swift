//
//  IBSegmentedControl.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

class IBSegmentedControl: IBView {
    
    private let segmentedControlProperties: [IBPropertyMapper] = [
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
        .init(ib: "image", functionName: "setImage", argumentNames: ["", "forSegmentAt"]),
        .init(ib: "contentOffset", functionName: "setContentOffset", argumentNames: ["", "forSegmentAt"]),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + segmentedControlProperties
    }
    
    var segmentCount = 0
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        switch elementTree {
        case "segments->segment":
            defer { segmentCount += 1 }
            if let title = attributes["title"], !title.isEmpty {
                putValueToArgument(ib: "title", value: title, type: .string, at: 0)
                putValueToArgument(ib: "title", value: segmentCount, type: .number, at: 1)
            }
            else if let imageName = attributes["image"] {
                guard let image = IBImage(attributes: attributes) else { return }
                putValueToArgument(ib: "image", value: image, type: .image, at: 0)
                putValueToArgument(ib: "image", value: segmentCount, type: .image, at: 1)
            }
        case "segments->segment->size":
            guard let key = attributes["key"],
                  let size = IBSize(attributes: attributes)
            else { return }
            putValueToArgument(ib: key, value: size, type: .size, at: 0)
            putValueToArgument(ib: key, value: segmentCount, type: .number, at: 1)
        default:
            break
        }
    }
}
