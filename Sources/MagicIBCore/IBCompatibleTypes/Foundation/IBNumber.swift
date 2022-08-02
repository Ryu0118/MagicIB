//
//  IBNumber.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

struct IBNumber: IBSwiftSourceGeneratable {
    let numberString: String
    var integer: Int? { Int(numberString) }
    var double: Double? { Double(numberString) }
    
    init(_ number: String) {
        self.numberString = number
    }
}
