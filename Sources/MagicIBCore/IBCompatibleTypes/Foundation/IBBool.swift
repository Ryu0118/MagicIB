//
//  IBBool.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

struct IBBool: IBSwiftSourceGeneratable {
    let boolString: String
    
    var bool: Bool {
        return boolString == "YES"
    }
    
    init?(_ bool: String) {
        if bool == "YES" || bool == "NO" {
            self.boolString = bool
        }
        else {
            return nil
        }
    }
}
