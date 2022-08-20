//
//  IBImage+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBImage: SwiftCodeGeneratable {
    
    func generateSwiftCode() -> [Line] {
        buildLines {
            if let systemName = self.systemName as? String {
                if let symbolScale = self.symbolScale as? String {
                    Line(variableName: "symbolConfiguration", lineType: .declare(isMutating: false, operand: "UIImage.SymbolConfiguration(scale: .\(symbolScale))"))
                    Line(variableName: "image", lineType: .declare(isMutating: false, operand: "UIImage(systemName: \"\(systemName))\", withConfiguration: symbolConfiguration)"))
                }
                else {
                    Line(variableName: "image", lineType: .declare(isMutating: false, operand: "UIImage(systemName: \"\(systemName))\""))
                }
            }
            else if let name = self.name as? String {
                Line(variableName: "image", lineType: .declare(isMutating: false, operand: "UIImage(named: \"\(name)\")"))
            }
            if let renderingMode = self.renderingMode as? String {
                Line(variableName: "image", lineType: .function("image?.withRenderingMode(.\(renderingMode)"))
            }
        }
    }
}
