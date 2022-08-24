//
//  IBOffset+generator.swift
//  
//
//  Created by Ryu on 2022/08/18.
//

import Foundation

extension IBOffset: SwiftCodeGeneratable, NonCustomizable, ZeroDiscriminable {
    var isZero: Bool {
        guard let horizontal = self.horizontal as? String,
              let vertical = self.vertical as? String else { return false }
        return Double(horizontal) == Double(vertical) && Double(horizontal) == 0
    }
    
    func generateSwiftCode() -> [Line] {
        guard let horizontal = self.horizontal as? String,
              let vertical = self.vertical as? String else { return [] }
        return buildLines {
            Line(variableName: "offset", lineType: .declare(isMutating: false, operand: "UIOffset(horizontal: \(horizontal), vertical: \(vertical))"))
        }
    }
}
