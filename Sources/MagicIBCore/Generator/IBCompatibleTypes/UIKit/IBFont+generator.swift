//
//  IBFont+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBFont: IBSwiftSourceGeneratable {
    
    func generateSwiftCode() -> String? {
        if let name = fontName,
           let size = size {
            return "UIFont(name: \(name), size: \(size)"
        }
        else if let type = type,
                let size = size {
            switch type {
            case .system:
                return ".systemFont(ofSize: \(size)"
            case .italicSystem:
                return ".italicSystemFont(ofSize: \(size)"
            case .boldSystem:
                return ".boldSystemFont(ofSize: \(size)"
            }
        }
        else if let style = style {
            return ".preferredFont(forTextStyle: .\(style)"
        }
        else {
            return nil
        }
    }
    
}
