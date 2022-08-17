//
//  IBFont+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBFont: IBSwiftSourceGeneratable {
    
    func generateSwiftCode() -> [Line] {
        if let name = fontName,
           let size = size {
            return Line(variableName: "font", lineType: .declare(isMutating: false, operand: "UIFont(name: \(name), size: \(size)")).toArray()
        }
        else if let type = type,
                let size = size {
            switch type {
            case .system:
                return Line(variableName: "font", lineType: .declare(isMutating: false, operand: ".systemFont(ofSize: \(size)")).toArray()
            case .italicSystem:
                return Line(variableName: "font", lineType: .declare(isMutating: false, operand: ".italicSystemFont(ofSize: \(size)")).toArray()
            case .boldSystem:
                return Line(variableName: "font", lineType: .declare(isMutating: false, operand: ".boldSystemFont(ofSize: \(size)")).toArray()
            }
        }
        else if let style = style {
            return Line(variableName: "font", lineType: .declare(isMutating: false, operand: ".preferredFont(forTextStyle: .\(style)")).toArray()
        }
        else {
            return nil
        }
    }
    
}
