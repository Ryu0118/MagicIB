//
//  File.swift
//  
//
//  Created by Ryu on 2022/08/31.
//

import Foundation

struct IBGestureRecognizer {
    let destination: String
    var gestureType: IBGestureType?
    
    init?(attributes: [String: String]) {
        guard let destination = attributes["destination"] else { return nil }
        self.destination = destination
    }
}
