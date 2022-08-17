//
//  IBColor+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBColor: IBSwiftSourceGeneratable {

    func generateSwiftCode() -> [Line] {
        if let red = self.red as? String,
           let green = self.green as? String,
           let blue = self.blue as? String,
           let alpha = self.alpha as? String {
            return Line(variableName: "color", lineType: .declare(isMutating: false, operand: "UIColor(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)")).toArray()
        }
        else if let systemColor = findProperty(ib: "systemColor")?.convertValidValue() {
            return Line(variableName: "color", lineType: .declare(isMutating: false, operand: systemColor)).toArray()
        }
        else if let name = self.name as? String {
            return Line(variableName: "color", lineType: .declare(isMutating: false, operand: "UIColor(named: \"\(name)\")")).toArray()
        }
        else {
            return nil
        }
     }
    
}
