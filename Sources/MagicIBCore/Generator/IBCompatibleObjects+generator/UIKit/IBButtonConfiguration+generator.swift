//
//  IBButtonConfiguration+generator.swift
//  
//
//  Created by Ryu on 2022/08/09.
//

import Foundation

extension IBButtonConfiguration: SwiftGeneratable {
    
    func generateSwiftCode() -> [Line] {
        guard let style = self.style as? String else { return [] }
        
        return buildLines {
            Line(variableName: "buttonConfiguration", lineType: .declare(isMutating: true, type: "UIButton.Configuration", operand: ".\(style)()"))
            
            generateCustomizablePropertyLines(variableName: "buttonConfiguration")
            generateBasicTypePropertyLines(variableName: "buttonConfiguration", except: ["style"])
            generateNonCustomizablePropertyLines(variableName: "buttonConfiguration")
        }
    }
    
}
