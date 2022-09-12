//
//  IBEdgeInsets+generator.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

extension IBEdgeInsets: SwiftGeneratable, NonCustomizable, ZeroDiscriminable {
    static let zero = IBEdgeInsets(attributes: ["minY": "0.0", "maxY": "0.0", "minX": "0.0", "maxX": "0.0"])
    
    var isZero: Bool {
        if let top = self.top as? String,
           let leading = self.leading as? String,
           let bottom = self.bottom as? String,
           let trailing = self.trailing as? String
        {
            return top == leading && leading == bottom && bottom == trailing && Double(trailing) == 0
        }
        else if let top = self.minY as? String,
                let bottom = self.maxY as? String,
                let left = self.minX as? String,
                let right = self.maxX as? String
        {
            return top == bottom && bottom == left && left == right && Double(right) == 0
        }
        else {
            return false
        }
    }
    
    func generateSwiftCode() -> [Line] {
        buildLines {
            if let top = self.top as? String,
               let leading = self.leading as? String,
               let bottom = self.bottom as? String,
               let trailing = self.trailing as? String
            {
                Line(variableName: "edgeInset", lineType: .declare(isMutating: false, operand: "NSDirectionalEdgeInsets(top: \(top), leading: \(leading), bottom: \(bottom), trailing: \(trailing))"))
            }
            else if let top = self.minY as? String,
                    let bottom = self.maxY as? String,
                    let left = self.minX as? String,
                    let right = self.maxX as? String
            {
                Line(variableName: "edgeInset", lineType: .declare(isMutating: false, operand: "UIEdgeInsets(top: \(top), left: \(left), bottom: \(bottom), right: \(right))"))
            }
        }
    }
}
