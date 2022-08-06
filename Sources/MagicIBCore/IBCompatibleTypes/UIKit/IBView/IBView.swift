//
//  IBView.swift
//  
//
//  Created by Ryu on 2022/07/28.
//

import Foundation

class IBView: IBAnyView, IBCompatibleObject {
    
    let id: String
    let customClass: String?
    let classType: IBCompatibleView
    let dependencies: IBViewDependencies
    
    var subviews = [IBView]()
    var parentElement: String? {
        waitingElementList[safe: waitingElementList.count - 2]
    }
    
    private(set) var constraints = [IBLayoutConstraint]()
    private(set) var elementTree: String!//ex) attributedString->fragment->attributes->color
    
    var waitingElementList = [String]() {
        didSet {
            var lastViewIndex: Int?
            for (i, element) in waitingElementList.reversed().enumerated() {
                if let _ = IBCompatibleView.init(rawValue: element) {
                    lastViewIndex = i
                    break
                }
            }
            elementTree = waitingElementList
                .suffix(lastViewIndex ?? 1)
                .joined(separator: "->")
        }
    }
    
    private let baseProperties: [IBPropertyMapper] = [
        .init(ib: "hidden", propertyName: "isHidden", type: .bool),
        .init(ib: "clipsSubviews", propertyName: "clipsToBounds", type: .bool),
        .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
        .init(ib: "alpha", propertyName: "alpha", type: .number),
        .init(ib: "multipleTouchEnabled", propertyName: "isMultipleTouchEnabled", type: .bool),
        .init(ib: "translatesAutoresizingMaskIntoConstraints", propertyName: "translatesAutoresizingMaskIntoConstraints", type: .bool),
        .init(ib: "autoresizingMask", propertyName: "autoresizingMask", type: .autoresizingMask),
        .init(ib: "contentMode", propertyName: "contentMode", type: .enum),
        .init(ib: "frame", propertyName: "frame", type: .cgRect),
        .init(ib: "backgroundColor", propertyName: "backgroundColor", type: .color),
        .init(ib: "tintColor", propertyName: "tintColor", type: .color),
        .init(ib: "opaque", propertyName: "isOpaque", type: .bool),
        .init(ib: "tag", propertyName: "tag", type: .number),
        .init(ib: "ambiguous", propertyName: "hasAmbiguousLayout", type: .bool),
    ]
        
    private let baseFunctions: [IBFunctionMapper] = [
        .init(ib: "horizontalHuggingPriority", functionName: "setContentHuggingPriority", argumentNames: ["", "for"]),
        .init(ib: "verticalHuggingPriority", functionName: "setContentHuggingPriority", argumentNames: ["", "for"]),
        .init(ib: "horizontalCompressionResistancePriority", functionName: "setContentCompressionResistancePriority", argumentNames: ["", "for"]),
        .init(ib: "verticalCompressionResistancePriority", functionName: "setContentCompressionResistancePriority", argumentNames: ["", "for"]),
    ]
    
    var properties: [IBPropertyMapper] { baseProperties }
    
    var functions: [IBFunctionMapper] { baseFunctions }

    var typeName: String {
        if let name = customClass {
            return name
        }
        else {
            return classType.description
        }
    }
    
    init?(attributes: [String: String],
          ibCompatibleView: IBCompatibleView
    ) {
        guard let id = attributes["id"] else { return nil }
        self.id = id
        self.classType = ibCompatibleView
        self.dependencies = IBViewDependencies(ibCompatibleView: classType)
        self.customClass = attributes["customClass"]
        self.mapping(attributes)
    }

    func addValueToProperties(attributes: [String: String]) {
        switch elementTree {
        case "rect":
            guard let propertyName = attributes["key"] else { return }
            guard propertyName == "frame" else { return }
            guard let rect = IBRect(attributes: attributes) else { return }
            addValueToProperty(ib: propertyName, value: rect)
        case "autoresizingMask":
            guard let propertyName = attributes["key"] else { return }
            let autoresizingMask = IBAutoresizingMask(attributes: attributes)
            addValueToProperty(ib: propertyName, value: autoresizingMask)
        case "color":
            guard let propertyName = attributes["key"] else { return }
            guard let color = IBColor(attributes: attributes) else { return }
            addValueToProperty(ib: propertyName, value: color)
        case "constraints->constraint":
            guard let constraint = IBLayoutConstraint(attributes, parentViewID: id) else { return }
            constraints.append(constraint)
        default:
            break
        }
    }
    
}

