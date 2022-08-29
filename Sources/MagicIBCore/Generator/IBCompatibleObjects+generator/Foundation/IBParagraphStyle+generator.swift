//
//  IBParagraphStyle+generator.swift
//  
//
//  Created by Ryu on 2022/08/18.
//

import Foundation

extension IBParagraphStyle: SwiftCodeGeneratable {
    func generateSwiftCode() -> [Line] {
        let variableName = "paragraphStyle"
        addEnumMapper()
        return buildLines {
            Line(variableName: variableName, lineType: .declare(isMutating: false, operand: "NSMutableParagraphStyle()"))
            generateBasicTypePropertyLines(variableName: variableName)
        }
    }
    
    private func addEnumMapper() {
        findProperty(ib: "lineBreakMode")?.addEnumMappers([
            .init(from: "tailTruncation", to: "byTruncatingTail"),
            .init(from: "middleTruncation", to: "byTruncatingMiddle"),
            .init(from: "headTruncation", to: "byTruncatingHead"),
            .init(from: "wordWrap", to: "byWordWrapping"),
            .init(from: "wordWrapping", to: "byWordWrapping"),
            .init(from: "characterWrap", to: "byCharWrapping"),
            .init(from: "clip", to: "byClipping"),
        ])
    }
}
