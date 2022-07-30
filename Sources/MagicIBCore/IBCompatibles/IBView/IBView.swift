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
    let dependencies: IBViewDependencies
    var properties: [IBPropertyMapping] {
        [
            .init(ib: "hidden", propertyName: "isHidden", type: .bool),
            .init(ib: "clipsSubviews", propertyName: "clipsToBounds", type: .bool),
            .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
            .init(ib: "alpha", propertyName: "alpha", type: .number),
            .init(ib: "semanticContentAttribute", propertyName: "semanticContentAttribute", type: .bool),
            .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
            .init(ib: "translatesAutoresizingMaskIntoConstraints", propertyName: "translatesAutoresizingMaskIntoConstraints", type: .bool),
            .init(ib: "autoresizingMask", propertyName: "autoresizingMask", type: .bool),
            .init(ib: "contentMode", propertyName: "contentMode", type: .enum),
            .init(ib: "hidden", propertyName: "isHidden", type: .bool),
            .init(ib: "clipsSubviews", propertyName: "clipsToBounds", type: .bool),
            .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
        ]
    }


    
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
    }
    
    func addValue(ib: String, value: String) {
        properties.addValue(ib: ib, value: value)
    }
    
}

private extension Array where Element == IBPropertyMapping {
    
    func excludeNil() -> [Element] {
        self.filter { $0.value != nil }
    }
    
    func addValue(ib: String, value: String) {
        self.filter { $0.ib == ib }
            .forEach {
                $0.addValue(value)
            }
    }
    
}

#endif
