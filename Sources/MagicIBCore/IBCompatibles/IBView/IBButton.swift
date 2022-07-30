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
        case buttonConfiguration
        case backgroundConfiguration
        case preferredSymbolConfiguration
        case attributedString
        case font
        case paragraphStyle
        case directionalEdgeInsets
    }
    
    override var properties: [IBPropertyMapper] {
        let viewProperties = super.properties
        let buttonProperties: [IBPropertyMapper] = [
            .init(ib: "highlighted", propertyName: "isHighlighted", type: .bool),
            .init(ib: "selected", propertyName: "isSelected", type: .bool),
            .init(ib: "buttonType", propertyName: "buttonType", type: .initializer),
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
        ]
        return viewProperties + buttonProperties
    }
    
    func addValueToProperties(elementType: IBButtonElementType, attributes: [String: String]) {
        
    }
    
}
#endif
