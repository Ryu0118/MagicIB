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
        case preferredSymbolConfiguration
        case attributedString
        case font
        case size
        case paragraphStyle
        case directionalEdgeInsets
    }
    
    override var properties: [IBPropertyMapper] {
        let viewProperties = super.properties
        let buttonProperties: [IBPropertyMapper] = [
            .init(ib: "highlighted", propertyName: "isHighlighted", type: .bool),
            .init(ib: "selected", propertyName: "isSelected", type: .bool),
            .init(ib: "buttonType", propertyName: "buttonType", type: .fullCustom),
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
            .init(ib: "configuration", propertyName: "configuration", type: .fullCustom),
            .init(ib: "background", propertyName: "background", type: .fullCustom),
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
            let rect = getCGRectFromAttributes(attributes: attributes)
            addValueToProperty(ib: propertyName, value: rect)
        case .autoresizingMask:
            let autoresizingMask = getAutoresizingMaskFromAttributes(attributes: attributes)
            addValueToProperty(ib: propertyName, value: autoresizingMask)
        case .color:
            if let property = properties.first(where: { $0.ib == "configuration" }), parentElement == "backgroundConfiguration" {
                insertColorAtButtonConfiguration(property: property, propertyName: propertyName)
            }
            else {
                let color = getColorFromAttributes(attributes: attributes)
                addValueToProperty(ib: propertyName, value: color)
            }
        case .constraint:
            guard let constraint = IBLayoutConstraint(attributes, parentViewID: id) else { return }
            constraints.append(constraint)
        case .buttonConfiguration:
            let buttonConfiguration = getButtonConfigurationFromAttributes(attributes: attributes)
            addValueToProperty(ib: propertyName, value: buttonConfiguration ?? "")
        case .backgroundConfiguration:
            let backgroundConfiguration = getButtonBackgroundConfigurationFromAttributes(attributes: attributes)
            addValueToProperty(ib: propertyName, value: backgroundConfiguration ?? "")
        case .preferredSymbolConfiguration:
            
        case .attributedString:
        case .font:
        case .size:
        case .paragraphStyle:
        case .directionalEdgeInsets:
        }
    }
    
    private func insertColorAtButtonConfiguration(property: IBPropertyMapper, propertyName: String) {
        guard let buttonConfiguration  = property.value as? String else { return }
        let color = getColorFromAttributes(attributes: attributes)
        let colorConfiguration = "backgroundConfiguration.\(propertyName) = \(color)"
        var lines = backgroundConfiguration.components(separatedBy: "\n")
        lines[lines.count - 2].append(colorConfiguration)
        
        property.value = lines.joined(separator: "\n")
    }
    
    private func getButtonBackgroundConfigurationFromAttributes(attributes: [String: String]) -> String? {
        let attributes = attributes.filter {  key, _ in key != "key" }
        guard let property = properties.first(where: { $0.ib == "configuration" }),
              let buttonConfiguration = property.value as? String
        else { return nil }
        var lines = buttonConfiguration.components(separatedBy: ".")
        let variableName = "backgroundConfiguration"
        var backgroundConfiguration = "var \(variableName): UIBackgroundConfiguration = .clear()"
        
        if let imageConstructor = getImageConstructorFromAttributes(attributes: attributes) {
            let imageConfiguration = "\(variableName).image = \(imageConstructor)"
            backgroundConfiguration.addLine(imageConfiguration)
        }
        if let imageContentMode = attributes["imageContentMode"] {
            let imageContentModeConfiguration = "\(variableName).imageContentMode = .\(imageContentMode)"
            backgroundConfiguration.addLine(imageContentModeConfiguration)
        }
        if let strokeWidth = attributes["strokeWidth"] {
            let strokeWidthConfiguration = "\(variableName).strokeWidth = \(strokeWidth)"
            backgroundConfiguration.addLine(strokeWidthConfiguration)
        }
        if let strokeOutset = attributes["strokeOutset"] {
            let strokeOutsetConfiguration = "\(variableName).strokeOutset = \(strokeOutset)"
            backgroundConfiguration.addLine(strokeOutset)
        }
        //lines[lines.count - 2] is before "{{VARIABLE_NAME}}.configuration = \(variableName)"
        lines[lines.count - 2].append(backgroundConfiguration)
        
        let buttonConfiguration = lines.joined(separator: "\n")
        property.value = buttonConfiguration
        
        return buttonConfiguration
    }
    
    private func getButtonConfigurationFromAttributes(attributes: [String: String]) -> String? {
        let attributes = attributes.filter { key, _ in key != "key" }
        guard let style = attributes["style"] else { return nil }
        
        let variableName = "buttonConfiguration"
        var constructButtonConfiguration = "var \(variableName): UIButton.Configuration = .\(style)()"
        
        //options
        if let constructor = getImageConstructorFromAttributes(attributes: attributes) {
            let imageConfiguration = "\(variableName).image = \(constructor)"
            constructButtonConfiguration.addLine(imageConfiguration)
        }
        if let imagePlacement = attributes["imagePlacement"] {
            let imagePlacementCode = "\(variableName).imagePlacement = .\(imagePlacement)"
            constructButtonConfiguration.addLine(imagePlacementCode)
        }
        if let imagePadding = attributes["imagePadding"] {
            let imagePaddingCode = "\(variableName).imagePadding = \(imagePadding)"
            constructButtonConfiguration.addLine(imagePaddingCode)
        }
        if let titlePadding = attributes["titlePadding"] {
            let titlePaddingCode = "\(variableName).titlePadding = \(titlePadding)"
            constructButtonConfiguration.addLine(titlePaddingCode)
        }
        if let titleAlignment = attributes["leading"] {
            let titleAlignmentCode = "\(variableName).titleAlignment = .\(titleAlignment)"
            constructButtonConfiguration.addLine(titleAlignmentCode)
        }
        if let cornerStyle = attributes["cornerStyle"] {
            let cornerStyleCode = "\(variableName).cornerStyle = .\(cornerStyle)"
            constructButtonConfiguration.addLine(cornerStyleCode)
        }
        if let showsActivityIndicator = attributes["showsActivityIndicator"] {
            let bool = showsActivityIndicator == "YES" ? "true" : "false"
            let showsActivityIndicatorCode = "\(variableName).showsActivityIndicator = \(bool)"
            constructButtonConfiguration.addLine(showsActivityIndicatorCode)
        }
        let buttonAssgined = "{{VARIABLE_NAME}}.configuration = \(variableName)"
        constructButtonConfiguration.addLine(buttonAssgined)
        return constructButtonConfiguration
        
    }
    
}
#endif
