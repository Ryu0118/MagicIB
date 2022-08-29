//
//  IBWebView+generator.swift
//  
//
//  Created by Ryu on 2022/08/29.
//

import Foundation

extension IBWebView {
    override func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        return buildLines {
            let variableName = classType.variableName
            let className = classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            generateInitializer()
            generateCustomizablePropertyLines(except: ["contentView", "configuration"])
            generateBasicTypePropertyLines()
            generateNonCustomizablePropertyLines()
            generateFunctions()
            Line(relatedVariableName: variableName, custom: "return \(variableName)")
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
    private func generateInitializer() -> [Line] {
        buildLines {
            if let configuration = self.configuration as? IBWebViewConfiguration {
                let configurationLines = configuration.generateSwiftCode()
                let configurationVariableName = configurationLines.first?.variableName ?? "configuration"
                
                configurationLines
                Line(variableName: classType.variableName, lineType: .declare(isMutating: false, type: nil, operand: "WKWebView(frame: .zero, configuration: \(configurationVariableName))"))
            }
            else {
                Line(variableName: classType.variableName, lineType: .declare(isMutating: false, type: nil, operand: "WKWebView()"))
            }
        }
    }
}
