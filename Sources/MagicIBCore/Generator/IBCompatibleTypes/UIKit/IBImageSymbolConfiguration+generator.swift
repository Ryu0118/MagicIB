//
//  IBImageSymbolConfiguration+generator.swift
//  
//
//  Created by Ryu on 2022/08/18.
//

import Foundation

extension IBImageSymbolConfiguration: SwiftCodeGeneratable, NonCustomizable {
    func generateSwiftCode() -> [Line] {
        if let configurationType = self.configurationType as? String {
            switch configurationType {
            case "font":
                if let scale = self.scale as? String {
                    return Line(variableName: "symbolConfiguration", lineType: .declare(isMutating: false, operand: "UIImage.SymbolConfiguration(font: <#T##UIFont#>, scale: <#T##UIImage.SymbolScale#>)"))
                }
            case "pointSize":
            default:
                break
            }
        }
    }
}
