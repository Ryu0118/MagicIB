//
//  IBOmittedType.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

// enum or static let
struct IBOmittedType: IBSwiftSourceGeneratable {
    let type: String
    init(_ type: String) {
        self.type = type
    }
}
