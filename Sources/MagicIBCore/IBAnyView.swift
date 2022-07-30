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
    var properties: [IBPropertyMapping] { get }
    var functions: [IBFunctionMapping] { get }
    func addValue(elementType: IBElementType, attributes: [String: String])
}
#endif
