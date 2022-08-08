//
//  IBImage+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBImage: IBSwiftSourceGeneratable {
    /*
     .init(propertyName: "systemName", type: .string),
     .init(propertyName: "name", type: .string),
     .init(propertyName: "symbolScale", type: .enum),
     .init(propertyName: "renderingMode", type: .enum),
     */
    func generateSwiftCode() -> String? {
        var swiftCode = ""
        if let systemName = self.systemName as? String {
            if let symbolScale = self.symbolScale as? String {
                swiftCode.addLine("let symbolConfiguration = UIImage.SymbolConfiguration(scale: .\(symbolScale)")
                swiftCode.addLine("let image = UIImage(systemName: \"\(systemName))\", withConfiguration: symbolConfiguration)")
            }
            else {
                swiftCode.addLine("let image = UIImage(systemName: \"\(systemName))\"")
            }
        }
        else if let name = self.name as? String {
            swiftCode.addLine("let image = UIImage(named: \"\(name)\")")
        }
        if let renderingMode = self.renderingMode as? String {
            swiftCode.addLine("image?.withRenderingMode(.\(renderingMode)")
        }
        return swiftCode.isEmpty ? nil : swiftCode
    }
    
}
