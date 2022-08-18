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

extension IBSwiftSourceGeneratable {
    func camelized(_ source1: String, _ source2: String) -> String {
        let dropped = source2.dropFirst()
        let initial = source2.prefix(1).uppercased()
        return initial + dropped
    }
}

extension IBCompatibleObject where Self: IBSwiftSourceGeneratable {
    func generateBasicTypePropertyLines(variableName: String, except: [String] = []) -> [Line] {
        activatedProperties
            .basicType()
            .except(except)
            .compactMap { property in
                guard let operand = property.convertValidValue() else { return nil }
                return Line(variableName: variableName, lineType: .assign(propertyName: property.propertyName, operand: operand))
            }
    }
    
    func generateNonCustomizablePropertyLines(variableName: String, except: [String] = []) -> [Line] {
        activatedProperties
            .except(except)
            .compactMap { property -> Line? in
                guard let nonCustomizable = property.value as? NonCustomizable else { return nil }
                return nonCustomizable.generateSwiftCode(variableName: variableName, propertyName: property.propertyName)
            }
    }
    
    func generateCustomizablePropertyLines(variableName: String, except: [String] = []) -> [Line] {
        activatedProperties
            .customType()
            .except(except)
            .compactMap { property -> [Line]? in
                guard let generator = property.value as? IBSwiftSourceGeneratable
                else { return nil }
                return generator
                    .generateSwiftCode()
                    .related(variableName: variableName, propertyName: property.propertyName)
            }
            .flatMap { $0 }
    }
}
