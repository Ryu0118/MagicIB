//
//  IBImage.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBImage {
    private(set) var systemName: String?
    private(set) var name: String?
    
    init?(attributes: [String: String]) {
        guard let image = attributes["image"] else { return nil }
        if let _ = attributes["catalog"] {
            self.systemName = image
        }
        else {
            self.name = image
        }
    }
}

