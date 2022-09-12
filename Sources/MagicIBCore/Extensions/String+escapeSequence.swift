//
//  String+escapeSequence.swift
//  
//
//  Created by Ryu on 2022/09/13.
//

import Foundation

extension String {
    func escapingSequence() -> String {
        self.map {
            if $0 == "\"" {
                return "\\" + "\($0)"
            }
            else {
                return "\($0)"
            }
        }
        .joined()
    }
}
