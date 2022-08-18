//
//  NonCustomizable.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

protocol NonCustomizable: SwiftCodeGeneratable {
    func generateSwiftCode(variableName: String, propertyName: String) -> Line?
}

extension NonCustomizable {
    func generateSwiftCode(variableName: String, propertyName: String) -> Line? {
        guard let operand = self.generateSwiftCode().first?.originalValue else { return nil }
        return Line(variableName: variableName, lineType: .assign(propertyName: propertyName, operand: operand))
    }
}
