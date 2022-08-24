//
//  IBButton+generator.swift
//  
//
//  Created by Ryu on 2022/08/25.
//

import Foundation

extension IBButton {
    override func generateSwiftCode() -> [Line] {
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
