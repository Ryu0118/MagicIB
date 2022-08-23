//
//  File.swift
//  
//
//  Created by Ryu on 2022/08/23.
//

import Foundation

extension IBLabel {
    
    override func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        return buildLines {
            let variableName = classType.variableName
            let className = classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)()"))
            generateCustomizablePropertyLines(except: ["contentView", "attributedText"])
            generateAttributedTextLines()
            generateBasicTypePropertyLines()
            generateNonCustomizablePropertyLines()
            Line(relatedVariableName: uniqueName, custom: "}()")
        }

    }
    
    private func generateAttributedTextLines() -> [Line] {
        buildLines {
            if let property = findProperty(ib: "attributedText"),
               let attributedText = property.value as? IBAttributedString
            {
                attributedText
                    .generateSwiftCode(mode: .legacy)
                    .related(variableName: classType.variableName, propertyName: property.propertyName)
            }
            
        }
    }
    
}
