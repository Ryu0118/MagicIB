//
//  IBImageSymbolConfiguration+generator.swift
//  
//
//  Created by Ryu on 2022/08/18.
//

import Foundation

extension IBImageSymbolConfiguration: SwiftGeneratable, NonCustomizable {
    func generateSwiftCode() -> [Line] {
        buildLines {
            if let configurationType = self.configurationType as? String {
                if configurationType == "font" {
                    fontLine()
                }
                else if configurationType == "pointSize" {
                    pointSizeLine()
                }
            }
            else {
                if let scale = self.scale as? String {
                    Line(variableName: "symbolConfiguration", lineType: .declare(isMutating: false, operand: "UIImage.SymbolConfiguration(scale: .\(scale))"))
                }
                else if let weight = self.weight as? String {
                    Line(variableName: "symbolConfiguration", lineType: .declare(isMutating: false, operand: "UIImage.SymbolConfiguration(weight: .\(weight))"))
                }
            }
        }
    }
    
    private func pointSizeLine() -> Line {
        var operand = "UIImage.SymbolConfiguration("
        if let pointSize = self.pointSize as? String {
            operand += "pointSize: \(pointSize)"
        }
        if let weight = self.weight as? String {
            if !operand.hasSuffix("UIImage.SymbolConfiguration(") {
                operand += ", "
            }
            operand += "weight: .\(weight)"
        }
        if let scale = self.scale as? String {
            if !operand.hasSuffix("UIImage.SymbolConfiguration(") {
                operand += ", "
            }
            operand += "scale: .\(scale)"
        }
        operand += ")"
        return Line(variableName: "symbolConfiguration", lineType: .declare(isMutating: false, operand: operand))
    }
    
    private func fontLine() -> Line? {
        guard let font = self.fontDescription as? IBFont,
              let rightOperand = font.getRightOperand()
        else { return nil }
        if let scale = self.scale as? String {
            return Line(variableName: "symbolConfiguration", lineType: .declare(isMutating: false, operand: "UIImage.SymbolConfiguration(font: \(rightOperand), scale: .\(scale))"))
        }
        else {
            return Line(variableName: "symbolConfiguration", lineType: .declare(isMutating: false, operand: "UIImage.SymbolConfiguration(font: \(rightOperand))"))
        }
    }
}
