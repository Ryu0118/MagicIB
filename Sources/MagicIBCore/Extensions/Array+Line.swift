//
//  Array+Line.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

extension Array where Element == Line {
    mutating func related(variableName: String, propertyName: String) -> [Line]? {
        guard let last = self.last else { return nil }
        var line: Line
        if self.count >= 2 {
            line = Line(variableName: variableName, lineType: .assign(propertyName: propertyName, operand: last.variableName))
        }
        else {
            self.removeLast()
            line = Line(variableName: variableName, lineType: .assign(propertyName: propertyName, operand: last.originalValue))
        }
        return self + [line]
    }
    
    func toString() -> String {
        return self
            .map { $0.line }
            .joined(separator: "\n")
    }
}
