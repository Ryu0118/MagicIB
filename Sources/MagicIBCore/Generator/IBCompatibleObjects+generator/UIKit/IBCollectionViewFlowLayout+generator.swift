//
//  IBCollectionViewFlowLayout+generator.swift
//  
//
//  Created by Ryu on 2022/08/20.
//

import Foundation

extension IBCollectionViewFlowLayout: SwiftGeneratable {
    
    func generateSwiftCode() -> [Line] {
        buildLines {
            Line(variableName: "layout", lineType: .declare(isMutating: false, type: nil, operand: "UICollectionViewFlowLayout()"))
            generateBasicTypePropertyLines(variableName: "layout")
            generateNonCustomizablePropertyLines(variableName: "layout")
        }
    }
    
}
