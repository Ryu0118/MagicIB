//
//  ArrayBuilder.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

@resultBuilder
enum ArrayBuilder<Element> {
    static func buildEither(first component: [Element]) -> [Element] {
        component
    }
    
    static func buildEither(second component: [Element]) -> [Element] {
        component
    }
    
    static func buildOptional(_ component: [Element]?) -> [Element] {
        component ?? []
    }
    
    static func buildExpression(_ expression: Element) -> [Element] {
        [expression]
    }
    
    static func buildExpression(_ expression: [Element]?) -> [Element] {
        expression ?? []
    }
    
    static func buildExpression(_ expression: Element?) -> [Element] {
        if let expression = expression {
            return [expression]
        }
        else {
            return []
        }
    }
    
    static func buildExpression(_ expression: ()) -> [Element] {
        []
    }
    
    static func buildBlock(_ components: [Element]...) -> [Element] {
        components.flatMap { $0 }
    }
    
    static func buildArray(_ components: [[Element]]) -> [Element] {
        Array(components.joined())
    }
}

