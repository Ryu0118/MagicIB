//
//  IBBlurEffect+generator.swift
//  
//
//  Created by Ryu on 2022/08/20.
//

import Foundation

extension IBBlurEffect: SwiftCodeGeneratable, NonCustomizable {
    func generateSwiftCode() -> [Line] {
        buildLines {
            if let style = self.style as? String {
                Line(variableName: "effect", lineType: .declare(isMutating: false, type: nil, operand: "UIBlurEffect(style: .\(style)"))
            }
            else {
                Line(variableName: "effect", lineType: .declare(isMutating: false, type: nil, operand: "UIBlurEffect()"))
            }
        }
    }
}
