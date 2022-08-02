//
//  IBView.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

class IBView: IBAnyView, IBCompatibleObject {
    typealias IBElementType = IBViewElementType
    
    enum IBViewElementType: String {
        case rect
        case autoresizingMask
        case color
        case constraint
    }
    
    let id: String
    let customClass: String?
    let classType: IBCompatibleView
    let dependencies: IBViewDependencies
    
    var constraints = [IBLayoutConstraint]()
    var subviews = [IBView]()
    var parentElement: String?
    
    var properties: [IBPropertyMapper] {
        [
            .init(ib: "hidden", propertyName: "isHidden", type: .bool),
            .init(ib: "clipsSubviews", propertyName: "clipsToBounds", type: .bool),
            .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
            .init(ib: "alpha", propertyName: "alpha", type: .number),
            .init(ib: "semanticContentAttribute", propertyName: "semanticContentAttribute", type: .bool),
            .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
            .init(ib: "translatesAutoresizingMaskIntoConstraints", propertyName: "translatesAutoresizingMaskIntoConstraints", type: .bool),
            .init(ib: "autoresizingMask", propertyName: "autoresizingMask", type: .autoresizingMask),
            .init(ib: "contentMode", propertyName: "contentMode", type: .enum),
            .init(ib: "frame", propertyName: "frame", type: .cgRect),
            .init(ib: "backgroundColor", propertyName: "backgroundColor", type: .color),
            .init(ib: "tintColor", propertyName: "tintColor", type: .color),
            .init(ib: "opaque", propertyName: "isOpaque", type: .bool),
            .init(ib: "tag", propertyName: "tag", type: .number),
            .init(ib: "ambiguous", propertyName: "hasAmbiguousLayout", type: .bool),
        ]
    }
    
    var functions: [IBFunctionMapper] {
        [
            .init(ib: "horizontalHuggingPriority", functionName: "setContentHuggingPriority", argumentNames: ["", "for"]),
            .init(ib: "verticalHuggingPriority", functionName: "setContentHuggingPriority", argumentNames: ["", "for"]),
            .init(ib: "horizontalCompressionResistancePriority", functionName: "setContentCompressionResistancePriority", argumentNames: ["", "for"]),
            .init(ib: "verticalCompressionResistancePriority", functionName: "setContentCompressionResistancePriority", argumentNames: ["", "for"]),
        ]
    }

    var typeName: String {
        if let name = customClass {
            return name
        }
        else {
            return classType.description
        }
    }
    
    init?(attributes: [String: String],
          ibCompatibleView: IBCompatibleView
    ) {
        guard let id = attributes["id"] else { return nil }
        self.id = id
        self.classType = ibCompatibleView
        self.dependencies = IBViewDependencies(ibCompatibleView: classType)
        self.customClass = attributes["customClass"]
        self.mapping(attributes)
    }
    
    func getCustomizedProperties() -> [IBPropertyMapper] {
        properties.filter { !($0.value as? String)?.isEmpty  }
    }
    
    func addValueToProperties(elementType: IBElementType, attributes: [String: String]) {
        if let propertyName = attributes["key"] { //properties
            switch elementType {
            case .rect:
                guard attributes["key"] == "frame" else { return }
                let rect = IBRect(attributes: attributes)
                addValueToProperty(ib: propertyName, value: rect)
            case .autoresizingMask:
                let autoresizingMask = IBAutoresizingMask(attributes: attributes)
                addValueToProperty(ib: propertyName, value: autoresizingMask)
            case .color:
                let color = IBColor(attributes: attributes)
                addValueToProperty(ib: propertyName, value: color)
            default:
                break
            }
        }
        else {
            if elementType == .constraint {
                guard let constraint = IBLayoutConstraint(attributes, parentViewID: id) else { return }
                constraints.append(constraint)
            }
        }
    }
    
}
#endif
/*
 
 func getImageConstructorFromAttributes(attributes: [String: String]) -> String? {
     guard let image = attributes["image"] else { return nil }
     
     var uiImageConstructor: String
     if let _ = attributes["catalog"] {
         uiImageConstructor = "UIImage(systemName: \(image))"
     }
     else {
         uiImageConstructor = "UIImage(named: \(image))"
     }
     return uiImageConstructor
 }
 
 func getCGRectFromAttributes(attributes: [String: String]) -> String {
     return attributes
         .filter { key, _ in key != "key" }
         .sorted(by: {
             let priority = ["x": 0, "y": 1, "width": 2, "height": 3]
             return priority[$0.key] ?? 0 < priority[$1.key] ?? 0
         })
         .compactMap{
             guard let _ = Double($1) else { return nil }
             return "\($0): \($1)"
         }
         .joined(separator: ", ")
         .insert(first: "CGRect(", last: ")")
 }
 
 func getAutoresizingMaskFromAttributes(attributes: [String: String]) -> [String] {
     return attributes
         .filter { key, value in key != "key" }
         .map { key, value in "." + key }
 }
 
 func getColorFromAttributes(attributes: [String: String]) -> String {
     let attributes = attributes.filter { key, _ in key != "key" }
     let isRGB = attributes.contains(where: { key, _ in
         let colors = ["red", "green", "blue"]
         return colors.contains(key)
     })
     let isSystemColor = attributes.contains(where: { key, _ in key == "systemColor" })
     let isNamed = attributes.contains(where: { key, _ in key == "name" })
     
     if isRGB {
         return "UIColor(red: \(attributes["red"] ?? "0"), green: \(attributes["green"] ?? "0"), blue: \(attributes["blue"] ?? "0"), alpha: \(attributes["alpha"] ?? "0")"
     }
     else if isSystemColor {
         var systemColor = attributes["systemColor"] ?? "white"
         // ex) systemPurpleColor
         if systemColor.lowercased().contains("color") {
             let colorIndex = systemColor.index(systemColor.endIndex, offsetBy: -5)
             systemColor.remove(at: colorIndex) //ex) systemPurple
         }
         return ".\(attributes["systemColor"] ?? "white")"
     }
     else if isNamed {
         return "UIColor(named: \"\(attributes["name"] ?? "AccentColor")\")"
     }
     else {
         return ".white"
     }
 }
 
 @discardableResult
 func addValueToProperty(ib: String, value: Any) -> IBPropertyMapper? {
     let properties = properties
         .filter { $0.ib == ib }
     properties
         .forEach { $0.addValue(value) }
     return properties.last
 }
 
 private func mapping(attributes: [String: String]) {
     attributes.forEach { key, value in
         properties
             .filter { $0.ib == key }
             .forEach { $0.addValue(value) }
         functions
             .filter { $0.ib == key }
             .forEach {
                 if $0.ib.contains("vertical") || $0.ib.contains("horizontal") {
                     let axis = $0.ib.contains("vertical") ? "vertical" : "horizontal"
                     $0.putValueToArgument("init(rawValue: \(value)", type: .enum, at: 0)
                     $0.putValueToArgument(axis, type: .enum, at: 1)
                 }
             }
     }
 }
 */
