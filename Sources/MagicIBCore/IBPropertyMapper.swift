//
//  IBPropertyMapping.swift
//  
//
//  Created by Ryu on 2022/07/30.
//
#if os(macOS)
import Foundation

class IBPropertyMapper {
    let ib: String
    let propertyName: String
    let type: IBInspectableType
    var value: Any! {
        didSet {
            switch type {
            case .font:
                if value as? IBFont == nil { fatalError("Different data type") }
            case .color:
                if value as? IBColor == nil { fatalError("Different data type") }
            case .cgRect:
                if value as? IBRect == nil { fatalError("Different data type") }
            case .image:
                if value as? IBImage == nil { fatalError("Different data type") }
            case .configuration:
                if value as? IBButtonConfiguration == nil { fatalError("Different data type") }
            case .paragraphStyle:
                if value as? IBParagraphStyle == nil { fatalError("Different data type") }
            case .autoresizingMask:
                if value as? IBAutoresizingMask == nil { fatalError("Different data type") }
            default:
                break
            }
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
}

#endif
