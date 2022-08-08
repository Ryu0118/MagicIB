//
//  IBRect+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBRect: IBSwiftSourceGeneratable {
    
    func generateSwiftCode() -> String? {
        guard let x = self.x as? String,
              let y = self.y as? String,
              let width = self.width as? String,
              let height = self.height as? String
        else { return nil }
        return "CGRect(x: \(x), y: \(y), width: \(width), height: \(height)"
    }
    
}
