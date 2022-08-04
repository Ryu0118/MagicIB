//
//  IBImageView.swift
//  
//
//  Created by Ryu on 2022/08/04.
//

import Foundation

final class IBImageView: IBView {
    
    private let imageProperties: [IBPropertyMapper] = [
        .init(propertyName: "image", type: .image),
        .init(ib: "highlighted", propertyName: "isHighlighted", type: .bool),
        .init(propertyName: "highlightedImage", type: .image),
        .init(propertyName: "preferredSymbolConfiguration", type: .symbolConfiguration),
        .init(propertyName: "semanticContentAttribute", type: .enum),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + imageProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        switch relation {
        case "imageReference":
            guard let propertyName = attributes["key"],
                  let image = IBImage(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: image)
        case "preferredSymbolConfiguration":
            guard let propertyName = attributes["key"] else { return }
            let symbolConfiguration = IBImageSymbolConfiguration(attributes: attributes)
            addValueToProperty(ib: propertyName, value: symbolConfiguration)
        default:
            break
        }
    }
}
