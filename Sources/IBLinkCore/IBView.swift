//
//  File.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

class IBView {
    let id: String
    let customClassName: String?
    let values: [IBInspectableValue]
    
    init?(attributes: [String: String]) {
        let converter = IBAttributeConverter(attributes)
        guard let id = converter.viewID else { return nil }
        self.id = id
        self.customClassName = converter.customClassName
        self.values = converter.generateIBInspectableValue()
    }
    
    func appendAttributes(attributes: [String: String]) {
        
    }
}
#endif
