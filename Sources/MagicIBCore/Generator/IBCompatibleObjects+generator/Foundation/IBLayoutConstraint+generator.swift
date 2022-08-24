//
//  IBLayoutConstraint+generator.swift
//  
//
//  Created by Ryu on 2022/08/23.
//

import Foundation

extension IBLayoutConstraint: SwiftCodeGeneratable {
    func generateSwiftCode() -> [Line] {
        let variableName = [firstItem, firstAttribute.rawValue, "constraint"].camelized()
        let arguments = buildArgument()
        let anchor = "\(firstItem).\(firstAttribute)Anchor.constraint(\(arguments))"
        
        return buildLines {
            Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: anchor))
            if let priority = self.priority {
                Line(variableName: variableName, lineType: .assign(propertyName: "priority", operand: " UILayoutPriority(rawValue: \(priority))"))
            }
        }
    }
    
    private func buildArgument() -> String {
        var arguments = [String]()
        if firstAttribute == .width || firstAttribute == .height {
            return layoutDimensionArguments().joined(separator: ", ")
        }
        else {
            return layoutAxisAnchorArguments().joined(separator: ", ")
        }
    }
    
    private func layoutAxisAnchorArguments() -> [String] {
        guard let secondItem = secondItem,
              let secondAttribute = secondAttribute
        else { return [] }
        var arguments = [String]()
        arguments.append("\(relation)To: \(secondItem).\(secondAttribute.rawValue)")
        if let constant = constant {
            arguments.append("constant: \(constant)")
        }
        return arguments
    }
    
    private func layoutDimensionArguments() -> [String] {
        var singleFlag = true
        var arguments = [String]()
        if let secondAttribute = secondAttribute,
           let secondItem = secondItem
        {
            arguments.append("\(relation.rawValue)To: \(secondItem).\(secondAttribute.rawValue)")
            singleFlag = false
        }
        if let multiplier = multiplier {
            arguments.append("multiplier: \(multiplier)")
        }
        if let constant = constant {
            if singleFlag {
                arguments.append("\(relation.rawValue)ToConstant: \(constant)")
            }
            else {
                arguments.append("constant: \(constant)")
            }
        }
        return arguments
    }
}

extension Array: SwiftCodeGeneratable where Element == IBLayoutConstraint {
    
    func generateSwiftCode() -> [Line] {
        buildLines {
            var lines = [Line]()
            
            lines.append(Line(relatedVariableName: "NSLayoutConstraint", custom: "NSLayoutConstraint.activate(["))
            for constraint in self {
                let code = constraint.generateSwiftCode()
                guard let firstLine = code.first else { continue }
                if let secondLine = code[safe: 1] {
                    lines.insert(firstLine, at: 0)
                    lines.insert(secondLine, at: 1)
                    lines.append(Line(relatedVariableName: secondLine.variableName, custom: secondLine.variableName + ","))
                }
                else {
                    lines.append(f)
                }
            }
        }
    }
    
}

private extension Array where Element == Line {
    
    func replaceIdToUniqueName(allViews: [IBView], constraints: [IBLayoutConstraint]) {
        guard let line = self.first else { return }
        guard self.count == 1 else { return }
        
        let a = self.map {
            let lineType = $0.lineType
            if case .custom(let custom) = lineType {
                custom.replacingOccurrences(of: "", with: <#T##StringProtocol#>)
            }
        }
    }
    
}
