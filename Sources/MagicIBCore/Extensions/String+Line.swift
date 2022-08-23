//
//  String+Line.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

extension String {
    static let end = "end"
    static let newLine = "newLine"
    static let fileHeader = "fileHeader"
    static let `import` = "import"
    static let `class` = "class"
    static let function = "function"
    
    func buildLines(relatedVariableName: String) -> [Line] {
        self
            .components(separatedBy: "\n")
            .map { Line(relatedVariableName: relatedVariableName, custom: $0) }
    }
    
    func indent(_ indentCount: Int) -> String {
        String(repeating: "    ", count: indentCount) + self
    }
}
