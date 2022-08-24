//
//  IBCollectionView+generator.swift
//  
//
//  Created by Ryu on 2022/08/25.
//

import Foundation

extension IBCollectionView {
    
    override func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        return buildLines {
            let variableName = classType.variableName
            let className = classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)()"))
            generateCustomizablePropertyLines(variableName: variableName, except: ["contentView"])
            generateBasicTypePropertyLines(variableName: variableName, except: ["dataMode"])
            generateNonCustomizablePropertyLines(variableName: variableName)
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
}
