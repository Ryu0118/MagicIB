//
//  IBLayoutGuide.swift
//  
//
//  Created by Ryu on 2022/08/24.
//

import Foundation

struct IBLayoutGuide {
    let id: String
    let key: String
    
    init(attributes: [String: String]) {
        self.id = attributes["id"] ?? ""
        self.key = attributes["key"] ?? ""
    }
}
