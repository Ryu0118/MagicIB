//
//  IBTextView+generator.swift
//  
//
//  Created by Ryu on 2022/08/27.
//

import Foundation

extension IBTextView {
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
            Line(relatedVariableName: variableName, custom: "return \(variableName)")
            Line(relatedVariableName: uniqueName, custom: "}()")
        }

    }
    
    private func generateAttributedTextLines() -> [Line] {
        buildLines {
            if let property = findProperty(ib: "attributedText"),
               let attributedText = property.value as? IBAttributedString
            {
                var code = attributedText.generateSwiftCode(mode: .legacy)
                code.related(variableName: classType.variableName, propertyName: property.propertyName)
            }
            
        }
    }
}
