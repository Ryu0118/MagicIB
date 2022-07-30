//
//  File.swift
//  
//
//  Created by Ryu on 2022/07/30.
//
#if os(macOS)
import Foundation

struct IBFunctionMapping {
    //ex) setContentHuggingPriority(.init(rawValue: 256), for: .vertical)
    let ib: String
    let functionName: String //setContentHuggingPriority
    let argumentNames: [String] //["", for]
    var argumentValues = [(argument: String, value: IBInspectableType)]()
    
    mutating func putArgument(_ value: String, type: IBInspectableType, at: Int) {
        argumentValues.insert((value, type), at: at)
    }
    
    func generateSwiftCode() throws -> String { //setContentHuggingPriority(.init(rawValue: 256), for: .vertical)
        guard argumentValues.count == argumentNames.count else { throw "Number of argumentNames and argumentValues do not match" }
        return zip(argumentNames, argumentValues)
            .map { name, value in
                if name.isEmpty {
                    return value.argument
                }
                else {
                    return name + ": " + value.argument
                }
            }
            .joined(separator: ", ")
            .appending(first: "\(functionName)(", last: ")")
    }
    
}
#endif
