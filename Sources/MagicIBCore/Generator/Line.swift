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
    
    static let end = Line(relatedVariableName: .end, custom: "}")
    static let newLine = Line(relatedVariableName: .newLine, custom: "\n")
    
    let variableName: String
    private var lineType: LineType
    
    var isStartOfBlock: Bool {
        originalValue.dropLast() == "{" || originalValue.dropLast() == "["
    }
    var isEndOfBlock: Bool {
        originalValue == "}" || originalValue == "]"
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
    
    init(variableName: String, lineType: LineType) {
        self.variableName = variableName
        self.lineType = lineType
    }
    
    init(relatedVariableName: String, custom: String) {
        self.variableName = relatedVariableName
        self.lineType = .custom(custom)
    }
    
}

extension Line {
    mutating func explicitType(_ type: String) -> Line {
        if originalValue.first == ".", case .declare(let isMutating, let optionalType, let operand) = lineType {
            lineType = .declare(isMutating: isMutating, type: optionalType, operand: type + operand)
        }
        return self
    }
}
