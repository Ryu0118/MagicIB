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
    func mapping(_ attributes: [String: String])
}

extension IBCompatibleObject {
    var functions: [IBFunctionMapper] { [] }
    func mapping(attributes: [String: String]) {
        attributes.forEach { key, value in
            properties
                .filter { $0.ib == key }
                .forEach { $0.addValue(value) }
            functions
                .filter { $0.ib == key }
                .forEach {
                    if $0.ib.contains("vertical") || $0.ib.contains("horizontal") {
                        let axis = $0.ib.contains("vertical") ? "vertical" : "horizontal"
                        $0.putValueToArgument("init(rawValue: \(value)", type: .enum, at: 0)
                        $0.putValueToArgument(axis, type: .enum, at: 1)
                    }
                }
        }
    }
}