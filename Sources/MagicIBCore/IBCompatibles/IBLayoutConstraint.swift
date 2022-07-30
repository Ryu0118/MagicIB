//
//  File.swift
//  
//
//  Created by Ryu on 2022/07/31.
//

#if os(macOS)
import Foundation

struct IBLayoutConstraint {
    
    enum Attribute: String {
        case top
        case bottom
        case width
        case height
        case leading
        case trailing
        case centerX
        case centerY
        case firstBaseline
    }
    
    enum Relation: String {
        case lessThanOrEqual
        case greaterThanOrEqual
    }
    
    enum Multiplier {
        case multiplier(Double)
        case aspectRatio(Double, Double)
        
        init?(_ multiplier: String) {
            let components = multiplier.components(separatedBy: ":")
            if components.count > 1 {
                guard let first = Double(components[0]),
                      let second = Double(components[1])
                else { return nil }
                self = .aspectRatio(first, second)
            }
            else {
                guard let multiplier = Double(multiplier) else { return nil }
                self = .multiplier(multiplier)
            }
        }
    }
    
    let id: String
    let firstItem: String
    let firstAttribute: Attribute
    let secondItem: String?
    let secondAttribute: Attribute?
    let multiplier: Multiplier?// ex) 1.1 2:3
    let priority: Int?
    let constant: Double?
    let relation: Relation?
    
    init?(_ attributes: [String: String], parentViewID: String) {
        guard let id = attributes["id"],
              let firstAttributeString = attributes["firstAttribute"],
              let firstAttribute: Attribute = .init(rawValue: firstAttributeString)
        else { return nil }
        
        if let firstItem = attributes["firstAttribute"] {
            self.firstItem = firstItem
        }
        else {
            self.firstItem = parentViewID
        }
        if let secondAttribute = attributes["secondAttribute"] {
            self.secondAttribute = .init(rawValue: secondAttribute)
        }
        if let multiplier = attributes["multiplier"] {
            self.multiplier = .init(multiplier)
        }
        self.id = id
        self.firstAttribute = firstAttribute
        self.secondItem = attributes["secondItem"]
    }
}
#endif
