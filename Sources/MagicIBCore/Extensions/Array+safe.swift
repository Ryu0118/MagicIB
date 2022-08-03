//
//  File.swift
//  
//
//  Created by Ryu on 2022/08/03.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
