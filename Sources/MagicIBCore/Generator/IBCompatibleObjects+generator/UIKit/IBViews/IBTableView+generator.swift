//
//  IBTableView+generator.swift
//  
//
//  Created by Ryu on 2022/08/27.
//

import Foundation

extension IBTableView {
    override func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        return buildLines {
            let variableName = classType.variableName
            let className = customClass ?? classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            generateTableViewInitializer()
            generateCustomizablePropertyLines(except: ["contentView"])
            generateBasicTypePropertyLines(except: ["dataMode", "style", "separatorStyle"])
            generateNonCustomizablePropertyLines()
            generateFunctions()
            Line(relatedVariableName: variableName, custom: "return \(variableName)")
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
    private func generateTableViewInitializer() -> [Line] {
        buildLines {
            if let style = self.style as? String {
                Line(variableName: classType.variableName, lineType: .declare(isMutating: false, type: nil, operand: "UITableView(frame: .zero, style: .\(style))"))
            }
            else {
                Line(variableName: classType.variableName, lineType: .declare(isMutating: false, type: nil, operand: "UITableView()"))
            }
        }
    }
}
