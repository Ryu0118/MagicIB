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
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: "UIView", operand: "{"))
            Line(variableName: "view", lineType: .declare(isMutating: false, type: nil, operand: "UIView()"))
            generateBasicTypePropertyLines(variableName: "view")
            generateNonCustomizablePropertyLines(variableName: "view")
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
}
