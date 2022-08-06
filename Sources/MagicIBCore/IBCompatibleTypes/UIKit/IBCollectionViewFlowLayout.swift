//
//  IBCollectionViewFlowLayout.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

struct IBCollectionViewFlowLayout: IBCompatibleObject {
    
    private let properties: [IBPropertyMapper] = [
        .init(propertyName: "scrollDirection", type: .enum),
        .init(propertyName: "minimumLineSpacing", type: .number),
        .init(propertyName: "minimumInteritemSpacing", type: .number),
        .init(propertyName: "itemSize", type: .size),
        .init(propertyName: "headerReferenceSize", type: .size),
        .init(propertyName: "footerReferenceSize", type: .size),
        .init(propertyName: "sectionInset", type: .edgeInsets),
    ]
    
    init(attributes: [String: String]) {
        mapping(attributes)
    }
    
}
