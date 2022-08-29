//
//  IBButton+generator.swift
//  
//
//  Created by Ryu on 2022/08/25.
//

import Foundation

extension IBButton {
    override func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        let variableName = classType.variableName
        let className = customClass ?? classType.description
        
        return buildLines {
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            
            generateButtonDeclaration()
            generateLabelFont()
            generateCustomizablePropertyLines()
            generateBasicTypePropertyLines(except: ["buttonType"])
            generateNonCustomizablePropertyLines(except: ["fontDescription"])
            generateFunctions()
            Line(relatedVariableName: variableName, custom: "return \(variableName)")
            Line(relatedVariableName: variableName, custom: "}()")
        }
    }
    
    private func generateLabelFont() -> [Line] {
        buildLines {
            if let font = self.fontDescription as? IBFont,
               let rightOperand = font.getRightOperand()
            {
                Line(variableName: "\(classType.variableName).titleLabel?", lineType: .assign(propertyName: "font", operand: rightOperand))
            }
        }
    }
    
    private func generateButtonDeclaration() -> [Line] {
        buildLines {
            if let buttonType = self.buttonType as? String {
                Line(variableName: classType.variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(classType.description)(type: .\(buttonType))"))
            }
            else {
                Line(variableName: classType.variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(classType.description)()"))
            }
        }
    }
}
