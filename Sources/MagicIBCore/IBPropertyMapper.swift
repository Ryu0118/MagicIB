//
//  IBPropertyMapping.swift
//  
//
//  Created by Ryu on 2022/07/30.
//
#if os(macOS)
import Foundation
import ObjectiveC

class IBPropertyMapper {
    let ib: String
    let propertyName: String
    let type: IBInspectableType
    var value: Any! {
//        get {
//            objc_getAssociatedObject(self, &_value)
//        }
//        set {
//            objc_setAssociatedObject(self, &_value, newValue.debugDescription, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
        didSet {
//            switch type {
//            case .font:
//                if value as? IBFont == nil { fatalError("Different data type") }
//            case .color:
//                if value as? IBColor == nil { fatalError("Different data type") }
//            case .cgRect:
//                if value as? IBRect == nil { fatalError("Different data type") }
//            case .image:
//                if value as? IBImage == nil { fatalError("Different data type") }
//            case .configuration:
//                if value as? IBButtonConfiguration == nil { fatalError("Different data type") }
//            case .paragraphStyle:
//                if value as? IBParagraphStyle == nil { fatalError("Different data type") }
//            case .autoresizingMask:
//                if value as? IBAutoresizingMask == nil { fatalError("Different data type") }
//            default:
//                break
//            }
        }
    }
    
    var isRequireInitializer: Bool {
        switch type {
        case .font, .color, .cgRect, .image, .configuration, .paragraphStyle, .autoresizingMask:
            return true
        default:
            return false
        }
    }
    
    init(ib: String, propertyName: String, type: IBInspectableType) {
        self.ib = ib
        self.propertyName = propertyName
        self.type = type
    }
    
    init(propertyName: String, type: IBInspectableType) {
        self.propertyName = propertyName
        self.ib = propertyName
        self.type = type
    }
    
    func addValue(_ value: Any) {
        self.value = value
    }
    
    func generateSwiftCode(variableName: String) -> String? {
        switch type {
        case .number:
            guard let value = value as? String else { return nil }
            return "\(variableName).\(propertyName) = \(value)"
        case .bool:
            guard let value = value as? String else { return nil }
            let convertedString = value == "YES" ? "true" : "false"
            return "\(variableName).\(propertyName) = \(convertedString)"
        case .enum:
            guard let value = value as? String else { return nil }
            return "\(variableName).\(propertyName) = .\(value)"
//        case .array:
//            if let value = value as? [String] {
//                let array =  value
//                    .joined(separator: ", ")
//                    .insert(first: "[", last: "]")
//                return "\(variableName).\(propertyName) = \(array)"
//            }
//            else if let value = value as? String {
//                return "\(variableName).\(propertyName) = .\(value)"
//            }
//            else {
//                return nil
//            }
        default:
            return nil
//        case .fullCustom:
//            guard let value = value as? String else { return nil }
//            /*
//             {{VARIABLE_NAME}}, which may be in value,
//             must be replaced by the name of the variable being set
//             */
//            return value.replacingOccurrences(of: "{{VARIABLE_NAME}}", with: variableName)
        }
    }
}

#endif
