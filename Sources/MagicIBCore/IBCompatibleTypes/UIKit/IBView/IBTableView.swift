//
//  IBTableView.swift
//  
//
//  Created by Ryu on 2022/08/05.
//

import Foundation

final class IBTableView: IBScrollView {
    private let tableViewProperties: [IBPropertyMapper] = [
        .init(propertyName: "dataMode", type: .enum),
        .init(propertyName: "style", type: .enum),
        .init(propertyName: "separatorStyle", type: .enum),
        .init(propertyName: "rowHeight", type: .number),
        .init(propertyName: "estimatedRowHeight", type: .number),
        .init(propertyName: "sectionHeaderHeight", type: .number),
        .init(propertyName: "estimatedSectionHeaderHeight", type: .number),
        .init(propertyName: "sectionFooterHeight", type: .number),
        .init(propertyName: "estimatedSectionFooterHeight", type: .number),
    ]
    
    var prototypes = [IBTableViewCell]()
    
    override var properties: [IBPropertyMapper] {
        super.properties + tableViewProperties
    }
}
