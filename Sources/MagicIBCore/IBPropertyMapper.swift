//
//  IBPropertyMapping.swift
//  
//
//  Created by Ryu on 2022/07/30.
//
#if os(macOS)
import Foundation

class IBPropertyMapper {
    let ib: String
    let propertyName: String
    let type: IBInspectableType
    var value: Any = ""
    
    init(ib: String, propertyName: String, type: IBInspectableType) {
        self.ib = ib
        self.propertyName = propertyName
        self.type = type
    }
    
    func addValue(_ value: Any) {
        self.value = value
    }
    
    func generateSwiftCode(variableName: String) -> String? {
        switch type {
        case .number, .initializer, .dynamicCode:
            guard let value = value as? String else { return nil }
            return "\(variableName).\(propertyName) = \(value)"
        case .bool:
            guard let value = value as? String else { return nil }
            let convertedString = value == "YES" ? "true" : "false"
            return "\(variableName).\(propertyName) = \(convertedString)"
        case .enum:
            guard let value = value as? String else { return nil }
            return "\(variableName).\(propertyName) = .\(value)"
        case .array:
            if let value = value as? [String] {
                let array =  value
                    .joined(separator: ", ")
                    .insert(first: "[", last: "]")
                return "\(variableName).\(propertyName) = \(array)"
            }
            else if let value = value as? String {
                return "\(variableName).\(propertyName) = .\(value)"
            }
            else {
                return nil
            }
        case .fullCustom:
            guard let value = value as? String else { return nil }
            /*
             {{VARIABLE_NAME}}, which may be in value,
             must be replaced by the name of the variable being set
             */
            return value.replacingOccurrences(of: "{{VARIABLE_NAME}}", with: variableName)
        }
    }
}

#endif
