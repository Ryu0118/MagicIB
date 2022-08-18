//
//  IBAttributedString+generator.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

extension IBAttributedString: SwiftCodeGeneratable {
    
    enum Mode {
        case modern
        case legacy
    }
    
    func generateSwiftCode() -> [Line] { generateSwiftCode(mode: .modern) }
    
    func generateSwiftCode(mode: Mode) -> [Line] {
        guard let variableName = uniqueName else { return [] }
        switch mode {
        case .modern:
            return buildLines {
                Line(variableName: variableName, lineType: .declare(isMutating: true, operand: "AttributedString(\"\(text)\""))
                fragments.flatMap { $0.generateSwiftCode }
            }
        case .legacy:
            return buildLines {
                
            }
        }
    }
    
}

extension IBAttributedString.Fragment: SwiftCodeGeneratable {
    func generateSwiftCode() -> [Line] {
        guard let content = self.content as? String,
              let variableName = self.uniqueName as? String
        else { return [] }
        return buildLines {
            Line(relatedVariableName: variableName, custom: "if let range = \(variableName).range(of: \"\(content)\") {")
            generateCustomizablePropertyLines(variableName: "\(variableName)[range]")
            generateNonCustomizablePropertyLines(variableName: "\(variableName)[range]")
            Line.end
        }
    }
}
