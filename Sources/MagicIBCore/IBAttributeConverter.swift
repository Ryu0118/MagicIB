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
    private var attributes: [String: String] = [:]
    private var cgRect: [String: String] = [:]
    private var autoresizingMask: [String: String] = [:]
    
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
    
    init(propertyName: String, configuration: [String: String]) {
        
    }
    
    init(cgRect: [String: String]) { //<rect x="0",y="1",width="120",height="100"/>
        self.cgRect = cgRect
    }
    
    init(autoresizingMask: [String: String]) { //<autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
        self.autoresizingMask = autoresizingMask
    }
    
    func generateIBInspectableProperty() -> [IBInspectableProperty] {
        let attributesProperty = attributes
            .filter({ key, value in !excludeProperties.contains(key) })
            .map { key, value -> IBInspectableProperty in
            let type = getType(key: key, value: value)
            return IBInspectableProperty(type: type, key: key, value: value)
        }
        
        let cgRect = cgRect
            .filter { key, value in key == "frame" }
            .sorted(by: {
                let priority = ["x": 0, "y": 1, "width": 2, "height": 3]
                return priority[$0.key] ?? 0 < priority[$1.key] ?? 0
            })
            .compactMap{
                guard let value = Double($1) else { return nil }
                return "\($0): \(value)"
            }
            .joined(separator: ", ")
            .appending(first: "CGRect(", last: ")")
            .as { IBInspectableProperty(type: .initializer, key: "frame", value: $0) }
        
        return attributesProperty + cgRect
    }
    
    func append(cgRect: [String: String]) {
        self.cgRect = cgRect
    }
    
    func append(autoresizingMask: [String: String]) {
        self.autoresizingMask.merge(autoresizingMask, uniquingKeysWith: { current, _ in current })
    }
    
    private func getType(key: String, value: String) -> IBInspectableType {
        if Double(value) != nil { // Real number types such as Int, Float, Double, CGFloat, etc.
            return .number
        }
        else if value == "YES" || value == "NO" { // true or false
            return .bool
        }
        else { // ex) scaleToFit, fillProportionally, .black
            return .enum
        }
    }
}

#endif
