//
//  IBPropertyMapping.swift
//  
//
//  Created by Ryu on 2022/07/30.
//
#if os(macOS)
import Foundation

class IBPropertyMapping {
    let ib: String
    let propertyName: String
    let type: IBInspectableType
    var value: String?
    
    init(ib: String, propertyName: String, type: IBInspectableType) {
        self.ib = ib
        self.propertyName = propertyName
        self.type = type
    }
    
    func addValue(_ value: String) {
        self.value = value
    }
    
    func generateSwiftCode() -> String? {
        guard let value = value else { return nil }
        switch type {
        case .number:
            return "\(propertyName) = \(value)"
        case .bool:
            let convertedString = value == "YES" ? "true" : "false"
            return "\(propertyName) = \(convertedString)"
        case .enum:
            return "\(propertyName) = .\(value)"
        case .initializer:
            return "\(propertyName) = \(value)"
        }
    }
}

#endif
