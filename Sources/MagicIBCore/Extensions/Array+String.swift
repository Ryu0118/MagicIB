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
                    let dropFirst = $1.dropFirst()
                    let initial = $1.prefix(1).lowercased()
                    return initial + dropFirst
                }
                else {
                    let dropFirst = $1.dropFirst()
                    let initial = $1.prefix(1).uppercased()
                    return initial + dropFirst
                }
            }
            .joined()
    }
}
