//
//  IBView.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

class IBView: IBAnyView {
    
    enum IBElementType: String {
        case rect
        case autoresizingMask
        case color
        case variation
        case size
    }
    
    let id: String
    let customClassName: String?
    let superClass: IBCompatibleView
    let dependencies: IBViewDependencies
    
    var properties: [IBPropertyMapping] {
        [
            .init(ib: "hidden", propertyName: "isHidden", type: .bool),
            .init(ib: "clipsSubviews", propertyName: "clipsToBounds", type: .bool),
            .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
            .init(ib: "alpha", propertyName: "alpha", type: .number),
            .init(ib: "semanticContentAttribute", propertyName: "semanticContentAttribute", type: .bool),
            .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
            .init(ib: "translatesAutoresizingMaskIntoConstraints", propertyName: "translatesAutoresizingMaskIntoConstraints", type: .bool),
            .init(ib: "autoresizingMask", propertyName: "autoresizingMask", type: .array),
            .init(ib: "contentMode", propertyName: "contentMode", type: .enum),
            .init(ib: "frame", propertyName: "frame", type: .initializer),
            .init(ib: "backgroundColor", propertyName: "backgroundColor", type: .enum),
            .init(ib: "tintColor", propertyName: "tintColor", type: .enum),
        ]
    }
    
    var functions: [IBFunctionMapping] {
        [
            .init(ib: "horizontalHuggingPriority", functionName: "setContentHuggingPriority", argumentNames: ["", "for"]),
            .init(ib: "verticalHuggingPriority", functionName: "setContentHuggingPriority", argumentNames: ["", "for"]),
            .init(ib: "horizontalCompressionResistancePriority", functionName: "setContentCompressionResistancePriority", argumentNames: ["", "for"]),
            .init(ib: "verticalCompressionResistancePriority", functionName: "setContentCompressionResistancePriority", argumentNames: ["", "for"]),
        ]
    }

    var typeName: String {
        if let name = customClassName {
            return name
        }
        else {
            return superClass.description
        }
    }
    
    init?(attributes: [String: String],
          ibCompatibleView: IBCompatibleView
    ) {
        guard let id = attributes["id"] else { return nil }
        self.id = id
        self.superClass = ibCompatibleView
        self.dependencies = IBViewDependencies(ibCompatibleView: superClass)
        self.customClassName = attributes["customClass"]
    }
    
    func getCustomizedProperties() -> [IBPropertyMapping] {
        properties
            .filter { $0.value != nil }
    }
    
    func addValue(elementName: String, attributes: [String: String]) {
        
    }
    
    func addValue(ib: String, value: String) {
        properties
            .filter { $0.ib == ib }
            .forEach { $0.addValue(value) }
    }
    
}
/*
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
 */
#endif
