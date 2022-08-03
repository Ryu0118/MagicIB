//
//  IBAnyView.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

#if os(macOS)
import Foundation

protocol IBAnyView: AnyObject {
    var properties: [IBPropertyMapper] { get }
    var functions: [IBFunctionMapper] { get }
    var typeName: String { get }
    func addValueToProperties(attributes: [String: String])
}
#endif
