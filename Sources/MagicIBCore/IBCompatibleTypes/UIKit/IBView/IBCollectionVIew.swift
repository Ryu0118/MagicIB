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
    ]
}
