//
//  IBOptionSet.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

struct IBOptionSet {
    let optionSet: Set<String>
    init?(attributes: [String: String]) {
        if attributes["none"] == "YES" { return nil }
        let array = attributes
            .filter { key, _ in key != "key" }
            .map { key, _ in "." + key }
        self.optionSet = Set(array)
    }
}
