//
//  IBVibrancyEffect+generator.swift
//  
//
//  Created by Ryu on 2022/08/20.
//

import Foundation

extension IBVibrancyEffect: SwiftCodeGeneratable, NonCustomizable {
    
    func generateSwiftCode() -> [Line] {
        guard let blurEffect = self.blurEffect as? IBBlurEffect,
              let blurEffectInitializer = blurEffect.getRightOperand()
        else { return [] }
        return buildLines {
            if let style = self.style {
                Line(variableName: "vibrancyEffect", lineType: .declare(isMutating: false, type: nil, operand: "UIVibrancyEffect(blurEffect: \(blurEffectInitializer), style: .\(style)"))
            }
            else {
                Line(variableName: "vibrancyEffect", lineType: .declare(isMutating: false, type: nil, operand: "UIVibrancyEffect(blurEffect: \(blurEffectInitializer)"))
            }
        }
    }
    
}
