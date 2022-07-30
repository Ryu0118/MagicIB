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
    var value: Any?
    
    init(ib: String, propertyName: String, type: IBInspectableType) {
        self.ib = ib
        self.propertyName = propertyName
        self.type = type
    }
    
    func addValue(_ value: String) {
        self.value = value
    }
    
    func generateSwiftCode() -> String? {
        switch type {
        case .number:
            guard let value = value as? String else { return nil }
            return "\(propertyName) = \(value)"
        case .bool:
            guard let value = value as? String else { return nil }
            let convertedString = value == "YES" ? "true" : "false"
            return "\(propertyName) = \(convertedString)"
        case .enum:
            guard let value = value as? String else { return nil }
            return "\(propertyName) = .\(value)"
        case .initializer:
            guard let value = value as? String else { return nil }
            return "\(propertyName) = \(value)"
        case .array:
            guard let value = value as? [String] else { return nil }
            let array = value
                .joined(separator: ", ")
                .appending(first: "[", last: "]")
            return "\(propertyName) = \(array)"
        }
    }
}

#endif
