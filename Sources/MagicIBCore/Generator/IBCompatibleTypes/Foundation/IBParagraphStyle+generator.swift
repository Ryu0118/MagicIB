//
//  IBParagraphStyle+generator.swift
//  
//
//  Created by Ryu on 2022/08/18.
//

import Foundation

extension IBParagraphStyle: IBSwiftSourceGeneratable {
    func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { fatalError("uniqueName has not been initialized") }
        buildLines {
            Line(variableName: camelized(uniqueName, "paragraphStyle"), lineType: .declare(isMutating: false, operand: "NSMutableParagraphStyle()"))
            generateBasicTypePropertyLines(variableName: "paragraphStyle")
        }
    }
}
