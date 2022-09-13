//
//  IBGestureRecognizer+generator.swift
//  
//
//  Created by Ryu on 2022/08/31.
//

import Foundation

class IBGestureRecognizer: UniqueName {
    let destination: String
    var gestureType: IBGestureType?
    var uniqueName: String?
    
    init?(attributes: [String: String]) {
        guard let destination = attributes["destination"] else { return nil }
        self.destination = destination
    }
}
