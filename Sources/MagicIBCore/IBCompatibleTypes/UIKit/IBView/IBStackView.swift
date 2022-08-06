//
//  IBStackView.swift
//  
//
//  Created by Ryu on 2022/08/06.
//

import Foundation

class IBStackView: IBView {
    
    private let stackViewProperties: [IBPropertyMapper] = [
        
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + stackViewProperties
    }
    
}
