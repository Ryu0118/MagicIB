//
//  IBTableView.swift
//  
//
//  Created by Ryu on 2022/08/05.
//

import Foundation

class IBTableView: IBScrollView {
    let tableViewProperties: [IBPropertyMapper] = [
        .init(propertyName: "dataMode", type: .enum),
    ]
    override var properties: [IBPropertyMapper] {
        super.properties + tableViewProperties
    }
}
