//
//  IBRect+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBRect: IBSwiftSourceGeneratable {
    
    func generateSwiftCode() -> String? {
        guard let x = findProperty(ib: "x")?.value as? String,
              let y = findProperty(ib: "y")?.value as? String,
              let width = findProperty(ib: "width")?.value as? String,
              let height = findProperty(ib: "height")?.value as? String
        else { return nil }
        return "CGRect(x: \(x), y: \(y), width: \(width), height: \(height)"
    }
    
}
