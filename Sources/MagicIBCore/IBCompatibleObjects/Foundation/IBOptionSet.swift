//
//  IBOptionSet.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

struct IBOptionSet {
    var optionSet: Set<String>
    init?(attributes: [String: String]) {
        if attributes["none"] == "YES" { return nil }
        let array = attributes
            .filter { key, _ in key != "key" }
            .map { key, _ in "." + key }
        self.optionSet = Set(array)
    }
    
    @discardableResult
    mutating func swap(from: String, to: String) -> Bool {
        guard let index = optionSet.firstIndex(of: from) else { return false }
        optionSet.remove(at: index)
        optionSet.insert(to)
        return true
    }
}
