//
//  IBView+generator.swift
//  
//
//  Created by Ryu on 2022/08/20.
//

import Foundation

extension IBView: SwiftCodeGeneratable {
    
    func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        return buildLines {
            let variableName = classType.variableName
            let className = classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)()"))
            generateCustomizablePropertyLines(variableName: variableName)
            generateBasicTypePropertyLines(variableName: variableName)
            generateNonCustomizablePropertyLines(variableName: variableName)
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
}
