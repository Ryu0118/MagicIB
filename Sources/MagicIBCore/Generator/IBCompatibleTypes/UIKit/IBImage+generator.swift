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
        if let systemName = findProperty(ib: "systemName")
    }
    
}
