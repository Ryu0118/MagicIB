//
//  IBWebViewConfiguration+generator.swift
//  
//
//  Created by Ryu on 2022/08/20.
//

import Foundation

extension IBWebViewConfiguration: SwiftCodeGeneratable {
    
    func generateSwiftCode() -> [Line] {
        buildLines {
            Line(variableName: "configuration", lineType: .declare(isMutating: false, type: nil, operand: "WKWebViewConfiguration()"))
            generateBasicTypePropertyLines(variableName: "configuration")
            generateNonCustomizablePropertyLines(variableName: "configuration")
        }
    }
    
}
