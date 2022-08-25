//
//  IBWebViewPreferences+generator.swift
//  
//
//  Created by Ryu on 2022/08/20.
//

import Foundation

extension IBWebViewPreferences: SwiftCodeGeneratable {
    
    func generateSwiftCode() -> [Line] {
        buildLines {
            Line(variableName: "preferences", lineType: .declare(isMutating: false, type: nil, operand: "WKPreferences()"))
            generateBasicTypePropertyLines(variableName: "preferences")
        }
    }
    
}
