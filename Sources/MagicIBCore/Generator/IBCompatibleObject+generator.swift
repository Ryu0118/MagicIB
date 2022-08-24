//
//  IBCompatibleObject+generator.swift
//  
//
//  Created by Ryu on 2022/08/19.
//

import Foundation

extension IBCompatibleObject where Self: SwiftCodeGeneratable {
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
                if let zeroDiscriminable = property.value as? ZeroDiscriminable,
                   zeroDiscriminable.isZero {
                    return nil
                }
                return nonCustomizable.generateSwiftCode(variableName: variableName, propertyName: property.propertyName)
            }
    }
    
    func generateCustomizablePropertyLines(variableName: String, except: [String] = []) -> [Line] {
        activatedProperties
            .customType()
            .except(except)
            .compactMap { property -> [Line]? in
                guard let generator = property.value as? SwiftCodeGeneratable
                else { return nil }
                if let zeroDiscriminable = property.value as? ZeroDiscriminable,
                   zeroDiscriminable.isZero {
                    return nil
                }
                return generator
                    .generateSwiftCode()
                    .related(variableName: variableName, propertyName: property.propertyName)
            }
            .flatMap { $0 }
    }
}

extension IBCompatibleObject where Self: IBView {
    
    func generateBasicTypePropertyLines(except: [String] = []) -> [Line] {
        generateBasicTypePropertyLines(variableName: classType.variableName, except: except)
    }
    
    func generateNonCustomizablePropertyLines(except: [String] = []) -> [Line] {
        generateNonCustomizablePropertyLines(variableName: classType.variableName, except: except)
    }
    
    func generateCustomizablePropertyLines(except: [String] = []) -> [Line] {
        generateCustomizablePropertyLines(variableName: classType.variableName, except: except)
    }
    
}
