//
//  IBSize+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBSize: IBSwiftSourceGeneratable {
    
    func generateSwiftCode() -> String? {
        guard let width = findProperty(ib: "width")?.value as? String,
              let height = findProperty(ib: "height")?.value as? String
        else { return nil }
        return "CGSize(width: \(width), height: \(height)"
    }
    
}
