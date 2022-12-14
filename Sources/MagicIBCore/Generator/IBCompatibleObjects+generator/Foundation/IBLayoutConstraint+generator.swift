//
//  IBLayoutConstraint+generator.swift
//  
//
//  Created by Ryu on 2022/08/23.
//

import Foundation

extension IBLayoutConstraint: SwiftGeneratable {
    func generateSwiftCode() -> [Line] {
        let variableName = getVariableName()
        let arguments = buildArgument()
        let anchor = "\(firstItem).\(firstAttribute)Anchor.constraint(\(arguments))"
        
        guard !arguments.isEmpty else {
            #if DEBUG
            print("arguments is empty: \(anchor)")
            #endif
            return []
        }
        
        return buildLines {
            Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: anchor))
            if let priority = self.priority {
                Line(variableName: variableName, lineType: .assign(propertyName: "priority", operand: "UILayoutPriority(rawValue: \(priority))"))
            }
        }
    }
    
    private func getVariableName() -> String {
        let firstAttributeName = firstAttribute.rawValue
        let dropFirst = firstAttributeName.dropFirst()
        let initial = firstAttributeName.prefix(1).uppercased()
        return firstItem + initial + dropFirst + "Constraint"
    }
    
    private func buildArgument() -> String {
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
        arguments.append("\(relation)To: \(secondItem).\(secondAttribute.rawValue)Anchor")
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
            arguments.append("\(relation.rawValue)To: \(secondItem).\(secondAttribute.rawValue)Anchor")
            singleFlag = false
        }
        if let multiplier = multiplier {
            switch multiplier {
            case .multiplier(let double):
                arguments.append("multiplier: \(double)")
            case .aspectRatio(let lhs, let rhs):
                let double = rhs / lhs
                if double != 1 {
                    arguments.append("multiplier: \(double)")
                }
            }
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

extension Array: SwiftGeneratable where Element == IBLayoutConstraint {
    
    func generateSwiftCode() -> [Line] {
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
                lines.append(Line(relatedVariableName: firstLine.variableName, custom: firstLine.originalValue + ","))
            }
        }
        
        lines.append(Line(relatedVariableName: "NSLayoutConstraint", custom: "])"))
        
        //If none of the constraints are present, an empty array is returned
        if lines.count == 2 {
            return []
        }
        return lines
    }
    
    
}

extension Array where Element == Line {
    
    func replaceIdToUniqueName(allViews: [IBView], constraints: [IBLayoutConstraint]) -> [Line] {
        for line in self {
            let viewIDs = getViewIDs(from: constraints)
            let layoutGuides = allViews.compactMap { ($0.uniqueName, $0.layoutGuides) }
            
            for viewID in viewIDs {
                if let uniqueName = allViews.getUniqueName(id: viewID), line.line.contains(viewID)
                {
                    line.appendReplacingString(of: viewID, with: uniqueName)
                }
            }
            
            for (uniqueName, layoutGuide) in layoutGuides {
                for viewLayoutGuide in layoutGuide {
                    guard let uniqueName = uniqueName else { continue }
                    guard line.line.contains(viewLayoutGuide.id) else { continue }
                    
                    if viewLayoutGuide.key == "safeArea" {
                        line.appendReplacingString(of: viewLayoutGuide.id, with: "\(uniqueName).\(viewLayoutGuide.key + "LayoutGuide")")
                    }
                    else
                    {
                        line.appendReplacingString(of: viewLayoutGuide.id, with: "\(uniqueName).\(viewLayoutGuide.key)")
                    }
                }
            }
        }
        return self
    }
    
    private func getViewIDs(from constraints: [IBLayoutConstraint]) -> [String] {
        constraints.reduce([String]()) { prev, element -> [String] in
            var prev = prev
            prev.append(element.firstItem)
            if let secondItem = element.secondItem {
                prev.append(secondItem)
            }
            return prev
        }
    }
    
}

private extension Array where Element == IBView {
    func getUniqueName(id: String) -> String? {
        self.filter { $0.id == id }.compactMap { $0.uniqueName }.first
    }
}
