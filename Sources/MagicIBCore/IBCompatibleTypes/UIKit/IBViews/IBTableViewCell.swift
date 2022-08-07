//
//  IBTableViewCell.swift
//  
//
//  Created by Ryu on 2022/08/05.
//

import Foundation

@dynamicMemberLookup
final class IBTableViewCell: IBView {
    private let tableViewCellProperties: [IBPropertyMapper] = [
        .init(propertyName: "selectionStyle", type: .enum),
        .init(propertyName: "indentationWidth", type: .number),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + tableViewCellProperties
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
