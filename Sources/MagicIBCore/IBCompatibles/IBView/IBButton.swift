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
            .init(ib: "configuration", propertyName: "configuration", type: .fullCustom)
            
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
            let color = getColorFromAttributes(attributes: attributes)
            addValueToProperty(ib: propertyName, value: color)
        case .constraint:
            guard let constraint = IBLayoutConstraint(attributes, parentViewID: id) else { return }
            constraints.append(constraint)
        case .buttonConfiguration:
            let configuration = getButtonConfigurationFromAttributes(attributes: attributes)
            addValueToProperty(ib: propertyName, value: configuration)
        case .backgroundConfiguration:
        case .preferredSymbolConfiguration:
        case .attributedString:
        case .font:
        case .size:
        case .paragraphStyle:
        case .directionalEdgeInsets:
        }
    }
    
    private func getButtonConfigurationFromAttributes(attributes: [String: String]) -> String? {
        let attributes = attributes.filter { key, _ in key != "key" }
        guard let style = attributes["style"] else { return nil }
        let variableName = "buttonConfiguration"
        let constructButtonConfiguration = "let \(variableName): UIButton.Configuration = .\(style)()"
        
        //options
        if let image = attributes["image"] {
            IBImageBuffer.shared.append(image)
            //{{IBImageBuffer}} is replaced by IBPropertyMapper when the catalog value of the image in the IB xml is known.
            "buffonConfiguration.image = {{IBImageBuffer:\(image)}}"
        }
    }
    
}
#endif
