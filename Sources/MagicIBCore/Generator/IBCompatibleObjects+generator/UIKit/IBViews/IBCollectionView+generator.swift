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
            let className = customClass ?? classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            generateInitializer()
            generateCustomizablePropertyLines(variableName: variableName, except: ["contentView", "collectionViewLayout"])
            generateBasicTypePropertyLines(variableName: variableName, except: ["dataMode"])
            generateNonCustomizablePropertyLines(variableName: variableName)
            Line(relatedVariableName: variableName, custom: "return \(variableName)")
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
    private func generateInitializer() -> [Line] {
        buildLines {
            let variableName = classType.variableName
            let className = classType.description
            
            if let layout = self.collectionViewLayout as? IBCollectionViewFlowLayout {
                let layoutLines = layout.generateSwiftCode()
                let layoutVariableName = layoutLines.first?.variableName ?? "layout"
                layoutLines
                Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)(frame: .zero, collectionViewLayout: \(layoutVariableName))"))
            }
            else {
                Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)()"))
            }
        }
    }
    
}
