//
//  IBColor+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBColor: SwiftCodeGeneratable, NonCustomizable {
    
    func generateSwiftCode() -> [Line] {
        buildLines {
            if let red = self.red as? String,
               let green = self.green as? String,
               let blue = self.blue as? String,
               let alpha = self.alpha as? String {
                Line(variableName: "color", lineType: .declare(isMutating: false, operand: "UIColor(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha))"))
            }
            else if var systemColor = findProperty(ib: "systemColor")?.convertValidValue() {
                systemColor = systemColor.replacingOccurrences(of: "Color", with: "")
                Line(variableName: "color", lineType: .declare(isMutating: false, operand: systemColor))
            }
            else if let name = self.name as? String {
                Line(variableName: "color", lineType: .declare(isMutating: false, operand: "UIColor(named: \"\(name)\")"))
            }
        }
    }
}
