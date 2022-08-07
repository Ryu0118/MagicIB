//
//  IBCollectionView.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

final class IBCollectionView: IBScrollView {
    
    private let collectionViewProperties: [IBPropertyMapper] = [
        .init(ib: "springLoaded", propertyName: "isSpringLoaded", type: .bool),
        .init(propertyName: "dataMode", type: .enum),
        .init(propertyName: "collectionViewLayout", type: .flowLayout),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + collectionViewProperties
    }
    
    var cells = [IBCollectionViewCell]()
    
    private var collectionViewFlowLayout: IBCollectionViewFlowLayout?

    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        switch elementTree {
        case "collectionViewFlowLayout":
            guard let propertyName = attributes["key"] else { return }
            collectionViewFlowLayout = IBCollectionViewFlowLayout(attributes: attributes)
            addValueToProperty(ib: propertyName, value: collectionViewFlowLayout!)
        case "collectionViewFlowLayout->size":
            guard let propertyName = attributes["key"],
                  let size = IBSize(attributes: attributes)
            else { return }
            collectionViewFlowLayout?.addValueToProperty(ib: propertyName, value: size)
        case "collectionViewFlowLayout->inset":
            guard let propertyName = attributes["key"],
                  let inset = IBEdgeInsets(attributes: attributes)
            else { return }
            collectionViewFlowLayout?.addValueToProperty(ib: propertyName, value: inset)
        default:
            break
        }
    }
    
}
