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
    let ibViewCompatibleElement: IBViewCompatibleElement
    let values: [IBInspectableValue]
    
    init?(attributes: [String: String], ibViewCompatibleElement: IBViewCompatibleElement) {
        let converter = IBAttributeConverter(attributes)
        guard let id = converter.viewID else { return nil }
        self.id = id
        self.ibViewCompatibleElement = ibViewCompatibleElement
        self.customClassName = converter.customClassName
        self.values = converter.generateIBInspectableValue()
    }
    
    func addValue(_ value: IBInspectableValue) {
        
    }
}
#endif
