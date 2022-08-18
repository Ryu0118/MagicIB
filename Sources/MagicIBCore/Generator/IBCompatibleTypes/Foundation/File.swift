//
//  File.swift
//  
//
//  Created by Ryu on 2022/08/18.
//

import Foundation

extension IBOptionSet: SwiftCodeGeneratable, NonCustomizable {
    func generateSwiftCode() -> [Line] {
        buildLines {
            if optionSet.count == 1, let first = optionSet.first {
                Line(variableName: "optionSet", lineType: .declare(isMutating: false, operand: "\(first)"))
            }
            else {
                let optionSet = optionSet
                    .joined(separator: ", ")
                    .insert(first: "[", last: "]")
                Line(variableName: "optionSet", lineType: .declare(isMutating: false, operand: optionSet))
            }
        }
    }
}
