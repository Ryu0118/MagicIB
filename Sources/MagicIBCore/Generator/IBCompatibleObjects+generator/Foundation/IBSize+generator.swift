//
//  IBSize+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBSize: SwiftCodeGeneratable, NonCustomizable, ZeroDiscriminable {
    
    static let zero = IBSize(attributes: ["width": "0.0", "height": "0.0"])
    
    var isZero: Bool {
        guard let width = self.width as? String,
              let height = self.height as? String
        else { return false }
        return width == height && Double(height) == 0
    }
    
    func generateSwiftCode() -> [Line] {
        guard let width = self.width as? String,
              let height = self.height as? String
        else { return [] }
        return buildLines {
            Line(variableName: "size", lineType: .declare(isMutating: false, operand: "CGSize(width: \(width), height: \(height))"))
        }
    }
    
}
