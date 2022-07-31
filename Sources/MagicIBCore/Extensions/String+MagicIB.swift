//
//  File.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

import Foundation

extension String: LocalizedError {
    
    func appending(first: String = "", last: String = "") -> String {
        return first + self + last
    }
    
    func `as`<T>(_ transform: (Self) throws -> T) rethrows -> [T] {
        try [self].map { try transform($0) }
    }
    
    mutating func addLine(_ string: String, newLineCount: Int = 1, indentCount: Int = 0) {
        self += String(repeating: "\n", count: newLineCount) + String(repeating: "    ", count: indentCount) + string
    }
    
}
