//
//  Array+IBPropertyMapper.swift
//  
//
//  Created by Ryu on 2022/08/19.
//

import Foundation

extension Array where Element == IBPropertyMapper {
    func except(_ type: [IBInspectableType]) -> [Element] {
        self.filter { !type.contains($0.type) }
    }
    
    func except(_ propertyNames: [String]) -> [Element] {
        self.filter { !propertyNames.contains($0.propertyName) }
    }
    
    func basicType() -> [Element] {
        let basicTypes: [IBInspectableType] = [.enum, .number, .bool, .string]
        return self.filter { basicTypes.contains($0.type) }
    }
    
    func customType() -> [Element] {
        let basicTypes: [IBInspectableType] = [.enum, .number, .bool, .string]
        return self.filter {
            !basicTypes.contains($0.type) && $0.value as? NonCustomizable == nil
        }
    }
}
