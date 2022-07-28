//
//  IBInspectableProperty.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

struct IBInspectableProperty {
    let type: IBInspectableType
    let key: String
    let originalValue: String
    
    init(type: IBInspectableType, key: String, value: String) {
        self.key = key
        self.type = type
        self.originalValue = value
    }
    
    func generateCode() -> String? {
        switch type {
        case .number:
            return "\(key) = \(originalValue)"
        case .bool:
            let value = originalValue == "YES" ? "true" : "false"
            return "\(key) = \(value)"
        case .enum:
            return "\(key) = .\(originalValue)"
        }
    }
}
#endif
