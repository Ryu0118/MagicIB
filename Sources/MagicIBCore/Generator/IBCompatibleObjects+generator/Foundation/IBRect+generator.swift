//
//  IBRect+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBRect: SwiftCodeGeneratable, NonCustomizable, ZeroDiscriminable {
    
    var isZero: Bool {
        guard let x = self.x as? String,
              let y = self.y as? String,
              let width = self.width as? String,
              let height = self.height as? String
        else { return false }
        return x == y && y == width && width == height && Double(height) == 0
    }
    
    func generateSwiftCode() -> [Line] {
        guard let x = self.x as? String,
              let y = self.y as? String,
              let width = self.width as? String,
              let height = self.height as? String
        else { return [] }
        return buildLines {
            Line(variableName: "edgeInsets", lineType: .declare(isMutating: false, operand: "CGRect(x: \(x), y: \(y), width: \(width), height: \(height))"))
        }
    }
    
}
