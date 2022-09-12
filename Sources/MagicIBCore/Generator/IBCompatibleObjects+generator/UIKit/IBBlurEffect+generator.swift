//
//  IBBlurEffect+generator.swift
//  
//
//  Created by Ryu on 2022/08/20.
//

import Foundation

extension IBBlurEffect: SwiftGeneratable, NonCustomizable {
    func generateSwiftCode() -> [Line] {
        buildLines {
            if let style = self.style as? String {
                Line(variableName: "blurEffect", lineType: .declare(isMutating: false, type: nil, operand: "UIBlurEffect(style: .\(style))"))
            }
            else {
                Line(variableName: "blurEffect", lineType: .declare(isMutating: false, type: nil, operand: "UIBlurEffect()"))
            }
        }
    }
}
