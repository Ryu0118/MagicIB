//
//  IBSize+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBSize: SwiftCodeGeneratable, NonCustomizable {
    
    func generateSwiftCode() -> String? {
        guard let width = self.width as? String,
              let height = self.height as? String
        else { return nil }
        return "CGSize(width: \(width), height: \(height)"
    }
    
}
