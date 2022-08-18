//
//  IBParagraphStyle+generator.swift
//  
//
//  Created by Ryu on 2022/08/18.
//

import Foundation

extension IBParagraphStyle: SwiftCodeGeneratable {
    func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { fatalError("uniqueName has not been initialized") }
        var variableName: String
        if uniqueName == "attributedText" {
            variableName = "paragraphStyle"
        }
        else {
            variableName = camelized(uniqueName, "paragraphStyle")
        }
        return buildLines {
            Line(variableName: variableName, lineType: .declare(isMutating: false, operand: "NSMutableParagraphStyle()"))
            generateBasicTypePropertyLines(variableName: "paragraphStyle")
        }
    }
}
