//
//  IBCollectionViewCell.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

final class IBCollectionViewCell: IBView {
    
    private let collectionViewCellProperties: [IBPropertyMapper] = [
        .init(propertyName: "contentView", type: .view)
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + collectionViewCellProperties
    }
    
    private var contentView: IBView?
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        guard let propertyName = attributes["key"] else { return }
        switch elementTree {
        case "collectionViewCellContentView":
            contentView = IBView(attributes: attributes, ibCompatibleView: .view)
            addValueToProperty(ib: contentView!, value: view)
        case "collectionViewCellContentView->rect":
            guard let rect = IBRect(attributes: attributes) else { return }
            contentView?.addValueToProperty(ib: propertyName, value: rect)
        case "collectionViewCellContentView->autoresizingMask":
            let autoresizingMask = IBAutoresizingMask(attributes: attributes)
            contentView?.addValueToProperty(ib: propertyName, value: autoresizingMask)
        case "collectionViewCellContentView->color":
            guard let color = IBColor(attributes: attributes) else { return }
            contentView?.addValueToProperty(ib: propertyName, value: color)
        default:
            break
        }
    }
    
}
