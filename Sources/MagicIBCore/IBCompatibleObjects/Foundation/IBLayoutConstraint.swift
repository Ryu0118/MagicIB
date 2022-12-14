//
//  IBLayoutConstraint.swift
//  
//
//  Created by Ryu on 2022/07/31.
//


import Foundation

struct IBLayoutConstraint {
    let id: String
    let firstItem: String
    let firstAttribute: Attribute
    let relation: Relation
    let secondItem: String?
    let secondAttribute: Attribute?
    let multiplier: Multiplier?// ex) 1.1 or 2:3
    let priority: Int?
    let constant: Double?
    
    init?(_ attributes: [String: String], parentViewID: String) {
        guard let id = attributes["id"],
              let firstAttributeString = attributes["firstAttribute"],
              let firstAttribute: Attribute = .init(firstAttributeString)
        else { return nil }
        
        if let firstItem = attributes["firstItem"] {
            self.firstItem = firstItem
        }
        else {
            self.firstItem = parentViewID
        }
        self.secondAttribute = .init(attributes["secondAttribute"] ?? "")
        self.multiplier = .init(attributes["multiplier"] ?? "")
        self.id = id
        self.firstAttribute = firstAttribute
        self.secondItem = attributes["secondItem"]
        self.priority = Int(attributes["priority"] ?? "")
        self.constant = Double(attributes["constant"] ?? "")
        self.relation = .init(rawValue: attributes["relation"] ?? "equal") ?? .equal
    }
}
//MARK: Declare Enum
extension IBLayoutConstraint {
    enum Attribute: String, Hashable {
        case top
        case bottom
        case width
        case height
        case leading
        case trailing
        case centerX
        case centerY
        case firstBaseline
        
        init?(_ rawValue: String) {
            let margins: [Attribute: String] = [
                .top: "topMargin",
                .bottom: "bottomMargin",
                .leading: "leadingMargin",
                .trailing: "trailingMargin"
            ]
            if let first = margins.first(where: { _, value in value == rawValue }) {
                self = first.key
            }
            else {
                guard let attribute = Attribute(rawValue: rawValue) else { return nil }
                self = attribute
            }
        }
    }
    
    enum Relation: String {
        case lessThanOrEqual
        case greaterThanOrEqual
        case equal
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
}


