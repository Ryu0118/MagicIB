//
//  IBFont+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBFont: SwiftCodeGeneratable, NonCustomizable {
    
    func generateSwiftCode() -> [Line] {
        return buildLines {
            if let name = fontName,
               let size = size {
                Line(variableName: "font", lineType: .declare(isMutating: false, operand: "UIFont(name: \(name), size: \(size)"))
            }
            else if let type = type,
                    let size = size {
                switch type {
                case .system:
                    Line(variableName: "font", lineType: .declare(isMutating: false, operand: ".systemFont(ofSize: \(size)"))
                case .italicSystem:
                    Line(variableName: "font", lineType: .declare(isMutating: false, operand: ".italicSystemFont(ofSize: \(size)"))
                case .boldSystem:
                    Line(variableName: "font", lineType: .declare(isMutating: false, operand: ".boldSystemFont(ofSize: \(size)"))
                }
            }
            else if let style = style {
                Line(variableName: "font", lineType: .declare(isMutating: false, operand: ".preferredFont(forTextStyle: .\(style)"))
            }
        }
    }
    
}
