//
//  IBFunctionMapper.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

import Foundation

class IBFunctionMapper {
    //ex) setContentHuggingPriority(.init(rawValue: 256), for: .vertical)
    let ib: String
    let functionName: String //setContentHuggingPriority
    let argumentNames: [String] //["", for]
    var argumentValues = [(value: Any, type: IBInspectableType)]()
    
    init(ib: String, functionName: String, argumentNames: [String]) {
        self.ib = ib
        self.functionName = functionName
        self.argumentNames = argumentNames
    }
    
    func putValueToArgument(_ value: Any, type: IBInspectableType, at: Int) {
        argumentValues.insert((value, type), at: at)
    }
    
    func convertValidValue(argumentValue: (value: Any, type: IBInspectableType)) -> String? {
        let (value, type) = argumentValue
        switch type {
        case .number:
            return value as? String
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

