//
//  IBBackgroundConfiguration+generator.swift
//  
//
//  Created by Ryu on 2022/08/18.
//

import Foundation

extension IBBackgroundConfiguration: SwiftCodeGeneratable {
    func generateSwiftCode() -> [Line] {
        buildLines {
            Line(variableName: "backgroundConfiguration", lineType: .declare(isMutating: true, operand: "UIBackgroundConfiguration.clear()"))
            generateCustomizablePropertyLines(variableName: "backgroundConfiguration")
            generateNonCustomizablePropertyLines(variableName: "backgroundConfiguration")
            generateBasicTypePropertyLines(variableName: "backgroundConfiguration")
        }
    }
}
