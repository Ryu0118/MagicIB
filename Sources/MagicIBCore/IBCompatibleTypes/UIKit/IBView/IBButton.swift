//
//  IBButton.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

#if os(macOS)
import Foundation

class IBButton: IBView {
    private var buttonConfiguration: IBButtonConfiguration?
    private var currentAttributedString: IBAttributedString?
    
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
    
    override func addValueToProperties(attributes: [String: String]) {
        super.addValueToProperties(attributes: attributes)
        switch relation {
        case "buttonConfiguration":
            guard let propertyName = attributes["key"] else { return }
            buttonConfiguration = IBButtonConfiguration(attributes: attributes)
            addValueToProperty(ib: propertyName, value: buttonConfiguration!)
        case "buttonConfiguration->attributedString":
            guard let buttonConfiguration = buttonConfiguration,
                  let propertyName = attributes["key"]
            else { return }
            
            currentAttributedString = IBAttributedString()
            buttonConfiguration.addValueToProperty(ib: propertyName, value: currentAttributedString!)
        case "buttonConfiguration->attributedString->fragment":
            guard let content = attributes["content"] else { return }
            currentAttributedString?.addFragment(content)
        case "buttonConfiguration->attributedString->fragment->attributes->color":
            currentAttributedString?.addColorAttributes(attributes)
        case "buttonConfiguration->attributedString->fragment->attributes->font":
            currentAttributedString?.addFontAttributes(attributes)
        case "buttonConfiguration->attributedString->fragment->attributes->paragraphStyle":
            currentAttributedString?.addParagraphStyle(attributes)
        case "buttonConfiguration->backgroundConfiguration":
            guard let backgroundConfiguration = IBBackgroundConfiguration(attributes: attributes) else { return }
            buttonConfiguration?.addValueToProperty(ib: "background", value: backgroundConfiguration)
        case "buttonConfiguration->backgroundConfiguration->color":
            guard let backgroundConfiguration = buttonConfiguration?.findProperty(ib: "background")?.value as? IBBackgroundConfiguration,
                  let propertyName = attributes["key"],
                  let color = IBColor(attributes: attributes)
            else { return }
            backgroundConfiguration.addValueToProperty(ib: propertyName, value: color)
        case "buttonConfiguration->backgroundConfiguration->imageReference":
            guard let backgroundConfiguration = buttonConfiguration?.findProperty(ib: "background")?.value as? IBBackgroundConfiguration,
                  let propertyName = attributes["key"],
                  let image = IBImage(attributes: attributes)
            else { return }
            backgroundConfiguration.addValueToProperty(ib: propertyName, value: image)
        case "buttonConfiguration->preferredSymbolConfiguration":
            guard let propertyName = attributes["key"],
                  let buttonConfiguration = buttonConfiguration
            else { return }
            let configuration = IBImageSymbolConfiguration(attributes: attributes)
            buttonConfiguration.addValueToProperty(ib: propertyName, value: configuration)
        case "buttonConfiguration->directionalEdgeInsets":
            guard let propertyName = attributes["key"],
                  let buttonConfiguration = buttonConfiguration,
                  let insets = IBEdgeInsets(attributes: attributes)
            else { return }
            buttonConfiguration.addValueToProperty(ib: propertyName, value: insets)
        case "buttonConfiguration->color":
            guard let propertyName = attributes["key"],
                  let buttonConfiguration = buttonConfiguration,
                  let color = IBColor(attributes: attributes)
            else { return }
            buttonConfiguration.addValueToProperty(ib: propertyName, value: color)
        default:
            break
        }
    }
}
#endif
