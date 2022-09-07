//
//  IBVisualEffectView+generator.swift
//  
//
//  Created by Ryu on 2022/09/07.
//

import Foundation

extension IBVisualEffectView {
    
    override func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        return buildLines {
            let variableName = classType.variableName
            let className = customClass ?? classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            generateInitializer()
            generateCustomizablePropertyLines(except: ["contentView"])
            generateBasicTypePropertyLines()
            generateNonCustomizablePropertyLines()
            generateFunctions()
            Line(relatedVariableName: variableName, custom: "return \(variableName)")
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
    private func generateInitializer() -> [Line] {
        buildLines {
            let variableName = classType.variableName
            let className = customClass ?? classType.description
            
            if let blurEffect = self.effect as? IBBlurEffect {
                let blurCode = blurEffect.generateSwiftCode()
                blurCode
                Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)(effect: \(blurCode.first?.variableName ?? "blurEffect"))"))
            }
            else if let vibrancyEffect = self.effect as? IBVibrancyEffect {
                let vibrancyCode = vibrancyEffect.generateSwiftCode()
                vibrancyCode
                Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)(effect: \(vibrancyCode.first?.variableName ?? "vibrancyEffect"))"))
            }
            else {
                Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)()"))
            }
        }
    }
    
}
