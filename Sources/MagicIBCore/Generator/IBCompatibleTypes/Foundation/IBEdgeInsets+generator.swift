//
//  IBEdgeInsets+generator.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

extension IBEdgeInsets: IBSwiftSourceGeneratable, NonCustomizable {
    func generateSwiftCode() -> [Line] {
        if let top = self.top as? String,
           let leading = self.leading as? String,
           let bottom = self.bottom as? String,
           let trailing = self.trailing as? String
        {
            return Line(variableName: "edgeInset", lineType: .declare(isMutating: false, operand: "NSDirectionalEdgeInsets(top: \(top), leading: \(leading), bottom: \(bottom), trailing: \(trailing)")).toArray()
        }
        else if let top = self.minY as? String,
                let bottom = self.maxY as? String,
                let left = self.minX as? String,
                let right = self.maxX as? String
        {
            return Line(variableName: "edgeInset", lineType: .declare(isMutating: false, operand: "UIEdgeInsets(top: \(top), left: \(left), bottom: \(bottom), right: \(right)")).toArray()
        }
        else {
            return []
        }
    }
}
