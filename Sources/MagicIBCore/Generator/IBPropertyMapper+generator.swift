//
//  IBPropertyMapper+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBPropertyMapper {
    
    func generateSwiftCode(variableName: String) -> String? {
        guard let value = value else { return nil }
        switch type {
        case .number:
            return "\(variableName).\(propertyName) = \(value)"
        case .bool:
            
        case .enum:
        case .string:
        case .font:
        case .color:
        case .size:
        case .array:
        case .cgRect:
        case .image:
        case .buttonConfiguration:
        case .paragraphStyle:
        case .backgroundConfiguration:
        case .symbolConfiguration:
        case .attributedString:
        case .edgeInsets:
        case .flowLayout:
        case .view:
        case .optionSet:
        case .visualEffect:
        case .wkWebViewConfiguration:
        case .wkPreferences:
        case .offsetWrapper:
        }
    }
    
    private func convertValidValue() -> String? {
        guard let value = value else { return nil }
        
        switch type {
        case .number:
            return value as? String
        case .bool:
            guard let value = value as? String else { return nil }
            return value == "YES" ? "true" : "false"
        case .enum:
            guard let value = value as? String else { return nil }
            return ".\(value)"
        case .string:
            guard let value = value as? String else { return nil }
            return "\"\(value)\""
        case .font:
            guard let font = value as? IBFont else { return nil }
            return font.generateSwiftCode()
        case .color:
            
        case .size:
        case .array:
        case .cgRect:
        case .image:
        case .buttonConfiguration:
        case .paragraphStyle:
        case .backgroundConfiguration:
        case .symbolConfiguration:
        case .attributedString:
        case .edgeInsets:
        case .flowLayout:
        case .view:
        case .optionSet:
        case .visualEffect:
        case .wkWebViewConfiguration:
        case .wkPreferences:
        case .offsetWrapper:
        }
    }
    
}
