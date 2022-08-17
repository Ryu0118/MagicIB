//
//  String+Line.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

extension String {
    func buildLines() -> [Line] {
        self
            .components(separatedBy: "\n")
            .map { Line(custom: $0) }
    }
}
