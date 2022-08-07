//
//  IBCollectionViewCell.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

@dynamicMemberLookup
final class IBCollectionViewCell: IBView {
    
    private let collectionViewCellProperties: [IBPropertyMapper] = [
        .init(propertyName: "contentView", type: .view),
        .init(propertyName: "sectionHeaderView", type: .view),
        .init(propertyName: "sectionFooterView", type: .view),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + collectionViewCellProperties
    }
    
    private var contentView: IBView?
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        guard let propertyName = attributes["key"] else { return }
        switch elementTree {
        case "collectionViewCellContentView":
            contentView = IBView(attributes: attributes, ibCompatibleView: .view)
            addValueToProperty(ib: propertyName, value: contentView!)
        case "collectionViewCellContentView->rect":
            guard let rect = IBRect(attributes: attributes) else { return }
            contentView?.addValueToProperty(ib: propertyName, value: rect)
        case "collectionViewCellContentView->autoresizingMask":
            guard let autoresizingMask = IBOptionSet(attributes: attributes) else { return }
            contentView?.addValueToProperty(ib: propertyName, value: autoresizingMask)
        case "collectionViewCellContentView->color":
            guard let color = IBColor(attributes: attributes) else { return }
            contentView?.addValueToProperty(ib: propertyName, value: color)
        default:
            break
        }
    }
    
}
