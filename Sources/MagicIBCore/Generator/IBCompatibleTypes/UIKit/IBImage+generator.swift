//
//  IBImage+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

struct ReturnType {
    let swiftCode: String
    let variableName: String?
}

struct Line {
    enum `Type` {
        case declare(isMutating: Bool, operand: String)
        case assign(propertyName: String, operand: String)
        case function(String)
    }
    
    let variableName: String
    let type: Type
    
    var line: String {
        switch type {
        case .declare(let isMutating, let operand):
            let varType = isMutating ? "var" : "let"
            return "\(varType) \(variableName) = \(operand)"
        case .assign(let propertyName, let operand):
            return "\(variableName).\(propertyName) = \(operand)"
        case .function(let function):
            return "\(variableName).\(function)"
        }
    }
    
    var originalValue: String {
        switch type {
        case .declare(let _, let operand):
            return operand
        case .assign(let propertyName, let operand):
            return operand
        case .function(let string):
            return string
        }
    }
}

extension IBImage: IBSwiftSourceGeneratable {
    
    func generateSwiftCode() -> [Line] {
        var lines = [Line]()
        if let systemName = self.systemName as? String {
            if let symbolScale = self.symbolScale as? String {
                lines.append(contentsOf: [
                    Line(variableName: "symbolConfiguration", type: .declare(isMutating: false, operand: "UIImage.SymbolConfiguration(scale: .\(symbolScale))")),
                    Line(variableName: "image", type: .declare(isMutating: false, operand: "UIImage(systemName: \"\(systemName))\", withConfiguration: symbolConfiguration)"))
                ])
            }
            else {
                lines.append(
                    Line(variableName: "image", type: .declare(isMutating: false, operand: "UIImage(systemName: \"\(systemName))\""))
                )
            }
        }
        else if let name = self.name as? String {
            lines.append(
                Line(variableName: "image", type: .declare(isMutating: false, operand: "UIImage(named: \"\(name)\")"))
            )
        }
        if let renderingMode = self.renderingMode as? String {
            lines.append(
                Line(variableName: "image", type: .function("image?.withRenderingMode(.\(renderingMode)"))
            )
        }
        return lines
    }
    
}
