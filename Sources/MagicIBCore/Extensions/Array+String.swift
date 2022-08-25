//
//  Array+String.swift
//  
//
//  Created by Ryu on 2022/08/24.
//

import Foundation

extension Array where Element == String {
    func camelized() -> String {
        self
            .enumerated()
            .map {
                if $0 == 0 {
                    return $1.lowercased()
                }
                else {
                    let lowercased = $1.lowercased()
                    let dropFirst = lowercased.dropFirst()
                    let initial = lowercased.prefix(1).uppercased()
                    return initial + dropFirst
                }
            }
            .joined()
    }
}
