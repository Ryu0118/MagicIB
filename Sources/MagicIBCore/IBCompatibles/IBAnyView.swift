//
//  IBAnyView.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

#if os(macOS)
import Foundation

protocol IBAnyView: AnyObject {
    associatedtype IBElementType
    var properties: [IBPropertyMapper] { get }
    var functions: [IBFunctionMapper] { get }
    var typeName: String { get }
    func addValueToProperties(elementType: IBElementType, attributes: [String: String])
}
#endif
