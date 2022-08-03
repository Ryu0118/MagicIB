//
//  IBButton.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

#if os(macOS)
import Foundation

class IBButton: IBView {
    typealias IBElementType = IBButtonElementType
    
    enum IBButtonElementType: String {
        case rect
        case autoresizingMask
        case color
        case constraint
        case buttonConfiguration
        case backgroundConfiguration
        case imageReference
        case preferredSymbolConfiguration
        case attributedString
        case font
        case size
        case paragraphStyle
        case directionalEdgeInsets
    }
    
    var buttonConfiguration: IBButtonConfiguration?
    
    override var properties: [IBPropertyMapper] {
        let viewProperties = super.properties
        let buttonProperties: [IBPropertyMapper] = [
            .init(ib: "highlighted", propertyName: "isHighlighted", type: .bool),
            .init(ib: "selected", propertyName: "isSelected", type: .bool),
            .init(ib: "buttonType", propertyName: "buttonType", type: .enum),
            .init(ib: "showsMenuAsPrimaryAction", propertyName: "showsMenuAsPrimaryAction", type: .bool),
            .init(ib: "contentHorizontalAlignment", propertyName: "contentHorizontalAlignment", type: .enum),
            .init(ib: "contentVerticalAlignment", propertyName: "contentVerticalAlignment", type: .enum),
            .init(ib: "reversesTitleShadowWhenHighlighted", propertyName: "reversesTitleShadowWhenHighlighted", type: .bool),
            .init(ib: "showsTouchWhenHighlighted", propertyName: "showsTouchWhenHighlighted", type: .bool),
            .init(ib: "adjustsImageSizeForAccessibilityContentSizeCategory", propertyName: "adjustsImageSizeForAccessibilityContentSizeCategory", type: .bool),
            .init(ib: "lineBreakMode", propertyName: "lineBreakMode", type: .enum),
            .init(ib: "springLoaded", propertyName: "isSpringLoaded", type: .bool),
            .init(ib: "pointerInteraction", propertyName: "isPointerInteractionEnabled", type: .bool),
            .init(ib: "changesSelectionAsPrimaryAction", propertyName: "changesSelectionAsPrimaryAction", type: .bool),
            .init(ib: "role", propertyName: "role", type: .bool),
            .init(ib: "configuration", propertyName: "configuration", type: .configuration),
        ]
        return viewProperties + buttonProperties
    }
    
    @available(*, unavailable)
    override func addValueToProperties(elementType: IBView.IBElementType, attributes: [String : String]) { }
    
    func addValueToProperties(elementType: IBElementType, attributes: [String: String]) {
        guard let propertyName = attributes["key"] else { return }
        switch elementType {
        case .rect:
            guard attributes["key"] == "frame" else { return }
            let rect = IBRect(attributes: attributes)
            addValueToProperty(ib: propertyName, value: rect)
        case .autoresizingMask:
            let autoresizingMask = IBAutoresizingMask(attributes: attributes)
            addValueToProperty(ib: propertyName, value: autoresizingMask)
        case .color:
            guard let color = IBColor(attributes: attributes) else { return }
            if let parentElement = parentElement,
               let backgroundProperty = buttonConfiguration?.findProperty(ib: "background"),
               let backgroundConfiguration = backgroundProperty.value as? IBBackgroundConfiguration,
               let key = attributes["key"],
               parentElement == "backgroundConfiguration"
            {
                backgroundConfiguration.addValueToProperty(ib: key, value: color)
            }
            else {
                addValueToProperty(ib: propertyName, value: color)
            }
        case .backgroundConfiguration:
            if let parentElement = parentElement,
               parentElement == "buttonConfiguration" {
                let backgroundConfiguration = IBBackgroundConfiguration(attributes: attributes)
                buttonConfiguration?.addValueToProperty(ib: "background", value: backgroundConfiguration)
            }
        case .constraint:
            guard let constraint = IBLayoutConstraint(attributes, parentViewID: id) else { return }
            constraints.append(constraint)
        case .buttonConfiguration:
            buttonConfiguration = IBButtonConfiguration(attributes: attributes)
            addValueToProperty(ib: propertyName, value: buttonConfiguration!)
        case .imageReference:
            guard let image = IBImage(attributes: attributes) else { return }
            if let parentElement = parentElement,
               let backgroundProperty = buttonConfiguration?.findProperty(ib: "background"),
               let backgroundConfiguration = backgroundProperty.value as? IBBackgroundConfiguration,
               let key = attributes["key"],
               parentElement == "backgroundConfiguration" {
                backgroundConfiguration.addValueToProperty(ib: key, value: image)
            }
        case .preferredSymbolConfiguration:
            guard let key = attributes["key"],
                  let buttonConfiguration = buttonConfiguration
            else { return }
            let configuration = IBImageSymbolConfiguration(attributes: attributes)
            buttonConfiguration.addValueToProperty(ib: key, value: configuration)
        case .attributedString:
            guard let key = attributes["key"] else { return }
            
        case .font:
        case .size:
        case .paragraphStyle:
        case .directionalEdgeInsets:
        }
    }
    
    
}

//private extension IBButton {
//
//    @discardableResult
//    func appendConfiguration(_ configuration: String) -> String? {
//        guard let property = properties.first(where: { $0.ib == "configuration" }),
//              let buttonConfiguration = property.value as? String
//        else { return nil }
//
//        var lines = buttonConfiguration.components(separatedBy: "\n")
//        //lines[lines.count - 2] is before "{{VARIABLE_NAME}}.configuration = \(variableName)"
//        lines[lines.count - 2].append(configuration)
//        let newConfiguration = lines.joined(separator: "\n")
//        property.value = newConfiguration
//        return configuration
//    }
//
//    func setImageReference(attributes: [String: String]) {
//        let attributes = attributes.filter { $0.key != "key" }
//        if let code = generateSwiftCode(variableName: "backgroundConfiguration", propertyName: "image", value: attributes["image"]) {
//            appendConfiguration(code)
//        }
//    }
//
//    func setPreferredSymbolConfiguration(attributes: [String: String]) {
//        let attributes = attributes.filter {  key, _ in key != "key" }
//        guard let configurationType = attributes["configurationType"] else { return }
//        if configurationType == "pointSize",
//           let pointSize = attributes["pointSize"],
//           let scale = attributes["scale"],
//           let weight = attributes["weight"]
//        {
//            let code = "buttonConfiguration.preferredSymbolConfigurationForImage = .init(pointSize: \(pointSize), weight: .\(weight), scale: .\(scale))"
//            appendConfiguration(code)
//        }
//    }
//
//    func insertColorAtButtonConfiguration(attributes: [String: String], propertyName: String, variableName: String) {
//        guard let property = properties.first(where: { $0.ib == "configuration" }),
//              let _ = property.value as? String
//        else { return }
//        let color = getColorFromAttributes(attributes: attributes)
//        let colorConfiguration = "\(variableName).\(propertyName) = \(color)"
//
//        appendConfiguration(colorConfiguration)
//    }
//
//    func getBackgroundConfiguration(attributes: [String: String]) {
//        let attributes = attributes.filter {  key, _ in key != "key" }
//        guard let property = properties.first(where: { $0.ib == "configuration" }),
//              let _ = property.value as? String
//        else { return }
//        let variableName = "backgroundConfiguration"
//        var backgroundConfiguration = "var \(variableName): UIBackgroundConfiguration = .clear()"
//
//        let options = [
//            (key: "image", value: getImageConstructorFromAttributes(attributes: attributes)),
//            (key: "imageContentMode", value: attributes["imageContentMode"]),
//            (key: "strokeWidth", value: attributes["strokeWidth"]),
//            (key: "strokeOutset", value: attributes["strokeOutset"]),
//        ]
//
//        for (key, value) in options {
//            if let code = generateSwiftCode(variableName: variableName, propertyName: key, value: value) {
//                backgroundConfiguration.addLine(code)
//            }
//        }
//
//        backgroundConfiguration.addLine("buttonConfiguration.background = \(variableName)")
//        return backgroundConfiguration
//    }
//
//    func generateSwiftCode(variableName: String, propertyName: String, value: String?) -> String? {
//        guard let value = value else { return nil }
//        if value == "YES" || value == "NO" {
//            let bool = value == "YES" ? "true" : "false"
//            return "\(variableName).\(propertyName) = \(bool)"
//        }
//        else if Double(value) != nil || propertyName == "title" {
//            return "\(variableName).\(propertyName) = \(value)"
//        }
//        else {
//            return "\(variableName).\(propertyName) = .\(value)"
//        }
//    }
//
//    func getButtonConfigurationFromAttributes(attributes: [String: String]) -> String? {
//        let attributes = attributes.filter { key, _ in key != "key" }
//        guard let style = attributes["style"] else { return nil }
//
//        let variableName = "buttonConfiguration"
//        var constructButtonConfiguration = "var \(variableName): UIButton.Configuration = .\(style)()"
//
//        //options
//        let options = [
//            (key: "image", value: getImageConstructorFromAttributes(attributes: attributes)),
//            (key: "imagePlacement", value: attributes["imagePlacement"]),
//            (key: "imagePadding", value: attributes["imagePadding"]),
//            (key: "title", value: attributes["title"]),
//            (key: "titlePadding", value: attributes["titlePadding"]),
//            (key: "leading", value: attributes["leading"]),
//            (key: "cornerStyle", value: attributes["cornerStyle"]),
//            (key: "showsActivityIndicator", value: attributes["showsActivityIndicator"]),
//        ]
//
//        for (key, value) in options {
//            if let code = generateSwiftCode(variableName: variableName, propertyName: key, value: value) {
//                constructButtonConfiguration.addLine(code)
//            }
//        }
//
//        let buttonAssgined = "{{VARIABLE_NAME}}.configuration = \(variableName)"
//        constructButtonConfiguration.addLine(buttonAssgined)
//        return constructButtonConfiguration
//
//    }
//
//}
#endif
