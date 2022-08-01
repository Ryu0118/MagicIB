//
//  IBRect.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBRect {
    let x: String
    let y: String
    let width: String
    let height: String
    
    init?(attributes: [String: String]) {
        guard let x = attributes["x"],
              let y = attributes["y"],
              let width = attributes["width"],
              let height = attributes["height"]
        else { return nil }
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}
