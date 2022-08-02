//
//  IBString.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

struct IBString: IBSwiftSourceGeneratable {
    let string: String
    init(_ string: String) {
        self.string = string
    }
}
