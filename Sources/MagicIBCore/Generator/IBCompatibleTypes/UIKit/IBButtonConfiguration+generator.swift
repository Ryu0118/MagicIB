//
//  IBButtonConfiguration+generator.swift
//  
//
//  Created by Ryu on 2022/08/09.
//

import Foundation

extension IBButtonConfiguration: IBSwiftSourceGeneratable {
    
    func generateSwiftCode() -> [Line] {
        guard let style = self.style as? String else { return [] }
        
        return buildLines {
            Line(variableName: "buttonConfiguration", lineType: .declare(isMutating: false, type: "UIButton.Configuration", operand: ".\(style)()"))
            if let image = self.image as? IBImage {
                image
                    .generateSwiftCode()
                    .related(variableName: "buttonConfiguration", propertyName: "image")
            }
            activatedProperties
                .basicType()
                .compactMap { property in
                    guard let operand = property.convertValidValue() else { return nil }
                    return Line(variableName: "buttonConfiguration", lineType: .assign(propertyName: property.propertyName, operand: operand))
                }
        }
    }
    
}
/*
 .init(propertyName: "style", type: .enum),
 .init(propertyName: "image", type: .image),
 .init(propertyName: "imagePlacement", type: .enum),
 .init(propertyName: "imagePadding", type: .number),
 .init(propertyName: "title", type: .string),
 .init(propertyName: "titlePadding", type: .number),
 .init(propertyName: "cornerStyle", type: .enum),
 .init(propertyName: "showsActivityIndicator", type: .bool),
 .init(propertyName: "background", type: .backgroundConfiguration),
 .init(propertyName: "preferredSymbolConfigurationForImage", type: .symbolConfiguration),
 .init(propertyName: "attributedTitle", type: .attributedString),
 .init(propertyName: "attributedSubtitle", type: .attributedString),
 .init(propertyName: "contentInsets", type: .edgeInsets),
 .init(propertyName: "baseForegroundColor", type: .color),
 .init(propertyName: "baseBackgroundColor", type: .color),
 */
