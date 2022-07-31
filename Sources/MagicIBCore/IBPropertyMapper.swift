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
    var imageNames: String?
    
    init(ib: String, propertyName: String, type: IBInspectableType) {
        self.ib = ib
        self.propertyName = propertyName
        self.type = type
    }
    
    func addValue(_ value: Any) {
        self.value = value
    }
    
    func generateSwiftCode() -> String? {
        switch type {
        case .number, .initializer, .dynamicCode:
            guard let value = value as? String else { return nil }
            return "\(propertyName) = \(value)"
        case .bool:
            guard let value = value as? String else { return nil }
            let convertedString = value == "YES" ? "true" : "false"
            return "\(propertyName) = \(convertedString)"
        case .enum:
            guard let value = value as? String else { return nil }
            return "\(propertyName) = .\(value)"
        case .array:
            if let value = value as? [String] {
                let array =  value
                    .joined(separator: ", ")
                    .appending(first: "[", last: "]")
                return "\(propertyName) = \(array)"
            }
            else if let value = value as? String {
                return "\(propertyName) = .\(value)"
            }
            else {
                return nil
            }
        case .fullCustom:
            guard let value = value as? String else { return nil}
            if value.contains("{{IBImageBuffer:") {
                value.replacingOccurrences(of: "{{IBImageBuffer}}", with: "\(IBImageBuffer)")
            }
        }
    }
}

#endif
