//
//  IBAutoresizingMask.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

struct IBAutoresizingMask {
    let autoresizingMask: [String]
    init(attributes: [String: String]) {
        self.autoresizingMask = attributes
            .filter { key, value in key != "key" }
            .map { key, value in "." + key }
    }
}
