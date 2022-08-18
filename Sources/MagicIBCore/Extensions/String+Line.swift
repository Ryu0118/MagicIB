//
//  String+Line.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

extension String {
    func buildLines(relatedVariableName: String) -> [Line] {
        self
            .components(separatedBy: "\n")
            .map { Line(relatedVariableName: relatedVariableName, custom: $0) }
    }
}