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
        case `class`(name: String, inheritances: [String])
    }
    
    static let end = Line(relatedVariableName: .end, custom: "}")
    static let newLine = Line(relatedVariableName: .newLine, custom: "\n")
    
    let variableName: String
    
    private var lineType: LineType
    private var indentCount = 0
    
    var isStartOfBlock: Bool {
        originalValue.suffix(1) == "{" || originalValue.suffix(1) == "["
    }
    var isEndOfBlock: Bool {
        originalValue.prefix(1) == "}" || originalValue.prefix(1) == "]"
    }
    
    var line: String {
        switch lineType {
        case .declare(let isMutating, let type, let operand):
            let varType = isMutating ? "var" : "let"
            if let type = type {
                return "\(varType) \(variableName): \(type) = \(operand)".indent(indentCount)
            }
            else {
                return "\(varType) \(variableName) = \(operand)".indent(indentCount)
            }
        case .assign(let propertyName, let operand):
            return "\(variableName).\(propertyName) = \(operand)".indent(indentCount)
        case .function(let function):
            return function.indent(indentCount)
        case .custom(let custom):
            return custom.indent(indentCount)
        case .class(let name, let inheritances):
            let inheritances = inheritances.joined(separator: ", ")
            return "class \(name): \(inheritances) {"
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
        case .class(_, _):
            return line
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
        if case .declare(let isMutating, let optionalType, let operand) = lineType,
           originalValue.first == "."
        {
            lineType = .declare(isMutating: isMutating, type: optionalType, operand: type + operand)
        }
        return self
    }
    
    mutating func indent(_ indentCount: Int) {
        self.indentCount = indentCount
    }
}
