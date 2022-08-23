//
//  Line.swift
//  
//
//  Created by Ryu on 2022/08/11.
//

import Foundation

struct Line {
    
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
        var line: String
        switch lineType {
        case .declare(let isMutating, let type, let operand):
            let varType = isMutating ? "var" : "let"
            if let type = type {
                line = "\(varType) \(variableName): \(type) = \(operand)"
            }
            else {
                line = "\(varType) \(variableName) = \(operand)"
            }
        case .assign(let propertyName, let operand):
            line = "\(variableName).\(propertyName) = \(operand)"
        case .function(let function):
            line = function
        case .custom(let custom):
            line = custom
        case .declareClass(let name, let inheritances):
            let inheritances = inheritances.joined(separator: ", ")
            line = "class \(name): \(inheritances) {"
        case .declareFunction(let function):
            let `override` = function.isOverride ? "override " : ""
            var accessLevel = function.accessLevel ?? ""
            let arguments = function.arguments.map { $0.string }.joined(separator: ", ")
            if !accessLevel.isEmpty {
                accessLevel += " "
            }
            line = "\(`override`)\(accessLevel)func \(function.name)(\(arguments)) {"
        }
        return line.indent(indentCount)
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
        case .declareClass(_, _):
            return line
        case .declareFunction(_):
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
    
    init(function: LineType.Function) {
        self.variableName = .function
        self.lineType = .declareFunction(function)
    }
    
}

extension Line {
    
    enum LineType {
        struct Argument {
            let argumentName: String
            let argumentType: String
            
            var string: String {
                "\(argumentName): \(argumentType)"
            }
        }
        struct Function {
            let name: String
            let arguments: [Argument]
            let accessLevel: String?
            let isOverride: Bool
        }
        
        case declare(isMutating: Bool, type: String? = nil, operand: String)
        case assign(propertyName: String, operand: String)
        case function(String)
        case custom(String)
        case declareClass(name: String, inheritances: [String])
        case declareFunction(Function)
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
