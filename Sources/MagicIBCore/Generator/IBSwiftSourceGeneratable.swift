//
//  IBSwiftSourceGeneratable.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

protocol IBSwiftSourceGeneratable {
    func generateSwiftCode() -> [Line]
    func buildLines(@ArrayBuilder<Line> _ builder: () -> [Line]) -> [Line]
}

extension IBSwiftSourceGeneratable {
    func buildLines(@ArrayBuilder<Line> _ builder: () -> [Line]) -> [Line] {
        builder()
    }
}

extension IBCompatibleObject where Self: IBSwiftSourceGeneratable {
    func generateBasicTypePropertyLines(variableName: String) -> [Line] {
        activatedProperties
            .basicType()
            .compactMap { property in
                guard let operand = property.convertValidValue() else { return nil }
                return Line(variableName: variableName, lineType: .assign(propertyName: property.propertyName, operand: operand))
            }
    }
    
    func generateNonCustomizablePropertyLines(variableName: String) -> [Line] {
        activatedProperties
            .compactMap { property -> Line? in
                guard let nonCustomizable = property.value as? NonCustomizable else { return nil }
                return nonCustomizable.generateSwiftCode(variableName: variableName, propertyName: property.propertyName)
            }
    }
}
