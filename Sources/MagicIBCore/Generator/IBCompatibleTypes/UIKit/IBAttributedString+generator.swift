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
                fragments.flatMap { $0.generateSwiftCode(mode: .modern) }
            }
        case .legacy:
            return buildLines {
                fragments.enumerated().flatMap { $1.generateSwiftCode(mode: .legacy(fragmentCount: $0)) }
            }
        }
    }
    
}

extension IBAttributedString.Fragment: SwiftCodeGeneratable {
    enum Mode {
        case modern
        case legacy(fragmentCount: Int)
    }
    
    func generateSwiftCode() -> [Line] { generateSwiftCode(mode: .modern) }
    
    func generateSwiftCode(mode: Mode) -> [Line] {
        guard let content = self.content as? String,
              let variableName = self.uniqueName as? String
        else { return [] }
        switch mode {
        case .modern:
            return buildLines {
                Line(relatedVariableName: variableName, custom: "if let range = \(variableName).range(of: \"\(content)\") {")
                generateCustomizablePropertyLines(variableName: "\(variableName)[range]")
                generateNonCustomizablePropertyLines(variableName: "\(variableName)[range]")
                Line.end
            }
        case .legacy(let count):
            let attributeName = "stringAttributes\(count + 1)"
            let stringName = "string\(count + 1)"
            return buildLines {
                Line(variableName: attributeName, lineType: .declare(isMutating: false, type: "[NSAttributedStringKey : Any]", operand: "["))
                activatedProperties.map {
                    $0.
                }
                Line(relatedVariableName: attributeName, custom: "]")
            }
        }
    }
}
