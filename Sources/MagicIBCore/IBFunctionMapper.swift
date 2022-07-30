//
//  File.swift
//  
//
//  Created by Ryu on 2022/07/30.
//
#if os(macOS)
import Foundation

class IBFunctionMapper {
    //ex) setContentHuggingPriority(.init(rawValue: 256), for: .vertical)
    let ib: String
    let functionName: String //setContentHuggingPriority
    let argumentNames: [String] //["", for]
    var argumentValues = [(argument: Any, type: IBInspectableType)]()
    
    init(ib: String, functionName: String, argumentNames: [String]) {
        self.ib = ib
        self.functionName = functionName
        self.argumentNames = argumentNames
    }
    
    func putValueToArgument(_ value: String, type: IBInspectableType, at: Int) {
        argumentValues.insert((value, type), at: at)
    }
    
    func generateSwiftCode() throws -> String { //setContentHuggingPriority(.init(rawValue: 256), for: .vertical)
        guard argumentValues.count == argumentNames.count else { throw "Number of argumentNames and argumentValues do not match" }
        return zip(argumentNames, argumentValues)
            .map { name, argumentValue in
                let value = convertValue(value: argumentValue.argument, type: argumentValue.type)
                if name.isEmpty {
                    return value ?? ""
                }
                else {
                    return name + ": " + (value ?? "")
                }
            }
            .joined(separator: ", ")
            .appending(first: "\(functionName)(", last: ")")
    }
    
    private func convertValue(value: Any, type: IBInspectableType) -> String? {
        switch type {
        case .number, .initializer, .custom:
            return value as? String
        case .bool:
            guard let value = value as? String else { return nil }
            let convertedString = value == "YES" ? "true" : "false"
            return convertedString
        case .enum:
            guard let value = value as? String else { return nil }
            return ".\(value)"
        case .array:
            if let value = value as? [String] {
                return value
                    .joined(separator: ", ")
                    .appending(first: "[", last: "]")
            }
            else {
                return value as? String
            }
        case .getonly:
            return nil
        }
    }
    
}
#endif
