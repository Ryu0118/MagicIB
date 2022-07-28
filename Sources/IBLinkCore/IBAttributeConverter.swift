//
//  IBAttributeConverter.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

class IBAttributeConverter: NSObject {
    private var excludeProperties = ["fixedFrame", "customClass", "id", "customModule"]
    private let attributes: [String: String]
    
    var viewID: String? {
        return attributes["id"]
    }
    
    var customClassName: String? {
        return attributes["customClass"]
    }
    
    var customModuleName: String? {
        return attributes["customModule"]
    }
    
    init(_ attributes: [String: String]) {
        self.attributes = attributes
    }
    
    func generateIBInspectableProperty() -> [IBInspectableProperty] {
        return attributes
            .filter({ key, value in !excludeProperties.contains(key) })
            .map { key, value -> IBInspectableProperty in
            let type = getType(key: key, value: value)
            return IBInspectableProperty(type: type, key: key, value: value)
        }
    }
    
    private func getType(key: String, value: String) -> IBInspectableType {
        if Double(value) != nil {
            return .number
        }
        else if value == "YES" || value == "NO" {
            return .bool
        }
        else { //enum
            return .enum
        }
    }
}
#endif
