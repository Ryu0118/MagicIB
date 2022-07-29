//
//  IBView.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

class IBView: NSObject {
    let id: String
    let customClassName: String?
    let superClass: IBCompatibleView
    let properties: [IBInspectableProperty]
    let dependencies: IBViewDependencies
    
    var typeName: String {
        if let name = customClassName {
            return name
        }
        else {
            return superClass.description
        }
    }
    
    init?(attributes: [String: String],
          ibCompatibleView: IBCompatibleView
    ) {
        let converter = IBAttributeConverter(attributes)
        guard let id = converter.viewID else { return nil }
        self.id = id
        self.superClass = ibCompatibleView
        self.dependencies = IBViewDependencies(ibCompatibleView: superClass)
        self.customClassName = converter.customClassName
        self.properties = converter.generateIBInspectableProperty()
    }
    
    func addValue(_ value: IBInspectableProperty) {
        
    }
}
#endif
