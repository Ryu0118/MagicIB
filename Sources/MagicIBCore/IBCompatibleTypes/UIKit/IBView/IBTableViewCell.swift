//
//  IBTableViewCell.swift
//  
//
//  Created by Ryu on 2022/08/05.
//

import Foundation

final class IBTableViewCell: IBView, IBCell {
    private let tableViewCellProperties: [IBPropertyMapper] = [
        .init(propertyName: "selectionStyle", type: .enum),
        .init(propertyName: "indentationWidth", type: .number),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + tableViewCellProperties
    }
}
