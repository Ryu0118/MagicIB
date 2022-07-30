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
    }
    
    let id: String
    let customClassName: String?
    let superClass: IBCompatibleView
    let dependencies: IBViewDependencies
    
    var properties: [IBPropertyMapper] {
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
    
    var functions: [IBFunctionMapper] {
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
        self.mapping(attributes: attributes)
    }
    
    func getCustomizedProperties() -> [IBPropertyMapper] {
        properties
            .filter { $0.value != nil }
    }
    
    func addValueToProperties(elementType: IBElementType, attributes: [String: String]) {
        guard let propertyName = attributes["key"] else { return }
        switch elementType {
        case .rect:
            let rect = getCGRectFromAttributes(attributes: attributes)
            addValueToProperty(ib: propertyName, value: rect)
        case .autoresizingMask:
            let autoresizingMask = getAutoresizingMaskFromAttributes(attributes: attributes)
            addValueToProperty(ib: propertyName, value: autoresizingMask)
        case .color:
            <#code#>
        }
    }
    
    func getCGRectFromAttributes(attributes: [String: String]) -> String {
        return attributes
            .filter { key, value in key == "frame" }
            .sorted(by: {
                let priority = ["x": 0, "y": 1, "width": 2, "height": 3]
                return priority[$0.key] ?? 0 < priority[$1.key] ?? 0
            })
            .compactMap{
                guard let _ = Double($1) else { return nil }
                return "\($0): \($1)"
            }
            .joined(separator: ", ")
            .appending(first: "CGRect(", last: ")")
    }
    
    func getAutoresizingMaskFromAttributes(attributes: [String: String]) -> [String] {
        return attributes
            .filter { key, value in key != "autoresizingMask" }
            .map { key, value in value }
    }
    
    func addValueToProperty(ib: String, value: Any) {
        properties
            .filter { $0.ib == ib }
            .forEach { $0.addValue(value) }
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
    
}
#endif
