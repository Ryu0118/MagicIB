//
//  IBAttributeConverter.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

class IBAttributeConverter: NSObject {
    private var excludeProperty = ["fixedFrame", "customClass"]
    private var functions = ["horizontalHuggingPriority", "verticalHuggingPriority"]
    private let attributes: [String: String]
    
    var viewID: String? {
        return attributes["id"]
    }
    
    var customClassName: String? {
        return attributes["customClass"]
    }
    
    init(_ attributes: [String: String]) {
        self.attributes = attributes
    }
    
    func generateIBInspectableValue() -> [IBInspectableValue] {
        return attributes
            .filter({ key, value in !excludeProperty.contains(key) })
            .map { key, value -> IBInspectableValue in
            let type = getType(key: key, value: value)
            return IBInspectableValue(type: type, key: key, value: value)
        }
    }
    
    private func getType(key: String, value: String) -> IBInspectableType {
        if Double(value) != nil {
            return .number
        }
        else if value == "YES" || value == "NO" {
            return .bool
        }
        else if functions.contains(key) {
            return .function
        }
        else if key == "id" {
            return .id
        }
        else { //enum
            return .enum
        }
    }
}
#endif
