//
//  IBSearchBar+generator.swift
//  
//
//  Created by Ryu on 2022/08/30.
//

import Foundation

extension IBSearchBar {
    override func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        addEnumMapper()
        return buildLines {
            let variableName = classType.variableName
            let className = customClass ?? classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)()"))
            generateCustomizablePropertyLines(except: ["contentView"])
            generateBasicTypePropertyLines()
            generateNonCustomizablePropertyLines()
            generateFunctions()
            Line(relatedVariableName: variableName, custom: "return \(variableName)")
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
    private func addEnumMapper() {
        findProperty(ib: "textContentType")?.addEnumMappers([
            .init(from: "url", to: "URL")
        ])
    }
}
