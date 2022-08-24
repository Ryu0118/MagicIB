//
//  IBButton+generator.swift
//  
//
//  Created by Ryu on 2022/08/25.
//

import Foundation

extension IBButton {
    override func generateSwiftCode() -> [Line] {
        buildLines {
            let variableName = classType.variableName
            let className = classType.description
            Line(variableName: variableName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            
            generateButtonDeclaration()
            if let font = self.fontDescription as? IBFont,
               let rightOperand = font.getRightOperand()
            {
                Line(variableName: "\(variableName).titleLabel?", lineType: .assign(propertyName: "font", operand: rightOperand))
            }
            generateCustomizablePropertyLines()
            generateBasicTypePropertyLines(except: ["buttonType"])
            generateNonCustomizablePropertyLines(except: ["fontDescription"])
            Line(relatedVariableName: variableName, custom: "}()")
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
