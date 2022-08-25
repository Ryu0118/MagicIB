//
//  IBCompatibleObject.swift
//  
//
//  Created by Ryu on 2022/08/02.
//

import Foundation

protocol IBCompatibleObject {
    var properties: [IBPropertyMapper] { get }
    var functions: [IBFunctionMapper] { get }
    var activatedProperties: [IBPropertyMapper] { get }
    func mapping(_ attributes: [String: String])
}

extension IBCompatibleObject {
    var functions: [IBFunctionMapper] { [] }
    
    var activatedProperties: [IBPropertyMapper] {
        properties.filter { $0.value != nil }
    }
    
    var activatedFunctions: [IBFunctionMapper] {
        functions.filter { !$0.argumentValues.isEmpty }
    }
    
    var isAllPropertiesActivated: Bool {
        activatedProperties.count == properties.count
    }
    
    @discardableResult
    func addValueToProperty(ib: String, value: Any?) -> IBPropertyMapper? {
        let properties = properties.filter { $0.ib == ib }
        properties.forEach { $0.addValue(value) }
        return properties.last
    }
    
    @discardableResult
    func putValueToArgument(ib: String, value: Any, type: IBInspectableType, at: Int) -> IBFunctionMapper? {
        let functions = functions.filter { $0.ib == ib }
        functions.forEach { $0.putValueToArgument(value, type: type, at: at) }
        return functions.last
    }
    
    func findProperty(ib: String) -> IBPropertyMapper? {
        properties.first(where: { $0.ib == ib })
    }
    
    func findFunction(ib: String) -> IBFunctionMapper? {
        functions.first(where: { $0.ib == ib })
    }
    
    func mapping(_ attributes: [String: String]) {
        attributes.forEach { key, value in
            properties
                .filter { $0.ib == key }
                .forEach { $0.addValue(value) }
            functions
                .filter { $0.ib == key }
                .forEach {
                    if $0.ib.contains("vertical") || $0.ib.contains("horizontal") {
                        let axis = $0.ib.contains("vertical") ? "vertical" : "horizontal"
                        $0.putValueToArgument("init(rawValue: \(value))", type: .enum, at: 0)
                        $0.putValueToArgument(axis, type: .enum, at: 1)
                    }
                }
        }
    }
}
