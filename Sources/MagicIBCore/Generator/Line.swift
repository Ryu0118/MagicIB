//
//  Line.swift
//  
//
//  Created by Ryu on 2022/08/11.
//

import Foundation

struct Line {
    enum LineType {
        case declare(isMutating: Bool, type: String? = nil, operand: String)
        case assign(propertyName: String, operand: String)
        case function(String)
        case custom(String)
    }
    
    static let end = Line(relatedVariableName: "custom", custom: "}")
    
    private let variableName: String
    private let lineType: LineType
    private let variableType: String?
    
    var isStartOfBlock: Bool {
        originalValue.dropLast() == "{"
    }
    var isEndOfBlock: Bool {
        originalValue.dropLast() == "}"
    }
    
    var line: String {
        switch lineType {
        case .declare(let isMutating, let type, let operand):
            let varType = isMutating ? "var" : "let"
            if let type = type {
                return "\(varType) \(variableName): \(type) = \(operand)"
            }
            else {
                return "\(varType) \(variableName) = \(operand)"
            }
        case .assign(let propertyName, let operand):
            return "\(variableName).\(propertyName) = \(operand)"
        case .function(let function):
            return "\(variableName).\(function)"
        case .custom(let custom):
            return custom
        }
    }
    
    var originalValue: String {
        switch lineType {
        case .declare(_, _, let operand):
            return operand
        case .assign(_, let operand):
            return operand
        case .function(let string):
            return string
        case .custom(let custom):
            return custom
        }
    }
    
    init(variableName: String, lineType: LineType, variableType: String? = nil) {
        self.variableName = variableName
        self.lineType = lineType
        self.variableType = variableType
    }
    
    init(relatedVariableName: String, custom: String) {
        self.variableName = relatedVariableName
        self.lineType = .custom(custom)
        self.variableType = nil
    }
    
}

extension Line {
    func toArray() -> [Line] {
        return [self]
    }
}
