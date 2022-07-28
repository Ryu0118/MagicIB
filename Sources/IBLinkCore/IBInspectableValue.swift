//
//  File.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

struct IBInspectableValue {
    let type: IBInspectableType
    let key: String
    let originalValue: String
    
    init(type: IBInspectableType, key: String, value: String) {
        self.key = key
        self.type = type
        self.originalValue = value
    }
    
    func generateCode() -> String? {
        if type == .function && key.hasSuffix("HuggingPriority") {
            let axis = key.hasPrefix("horizontal") ? "horizontal" : "vertical"
            let doubleValue = Double(originalValue) ?? 0
            return "setContentHuggingPriority(UILayoutPriority(rawValue: \(doubleValue), for: .\(axis)"
        }
        else {
            let value = { () -> String? in
                switch type {
                case .number, .id:
                    return originalValue
                case .bool:
                    return originalValue == "YES" ? "true" : "false"
                case .enum:
                    return ".\(originalValue)"
                default:
                    return nil
                }
            }()
            guard let value = value else { return nil }
            return "\(key) = \(value)"
        }
    }
}
#endif
