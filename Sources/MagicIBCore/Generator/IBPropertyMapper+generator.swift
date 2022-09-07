//
//  IBPropertyMapper+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBPropertyMapper {
    
    func convertValidValue() -> String? {
        guard let value = value else { return nil }
        
        switch type {
        case .number, .anyInstance:
            return "\(value)"
        case .bool:
            guard let value = value as? String else { return nil }
            return value == "YES" ? "true" : "false"
        case .enum:
            guard let value = value as? String else { return nil }
            return ".\(value)"
        case .string:
            guard let value = value as? String else { return nil }
            return "\"\(value)\""
        default:
            guard let nonCustomizable = value as? NonCustomizable else { return nil }
            return nonCustomizable.getRightOperand()
        }
    }
    
}
