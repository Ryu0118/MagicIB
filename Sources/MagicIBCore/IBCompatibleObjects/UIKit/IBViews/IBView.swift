//
//  IBView.swift
//  
//
//  Created by Ryu on 2022/07/28.
//

import Foundation

@dynamicMemberLookup
class IBView: NSObject, IBCompatibleObject, UniqueName, SwiftGeneratable {
    
    let id: String
    let customClass: String?
    let customModule: String?
    let classType: IBCompatibleViewType
    let dependencies: IBViewDependencies
    
    var subviews = [IBView]()
    var parentElement: String? {
        waitingElementList[safe: waitingElementList.count - 2]
    }
    
    private(set) var constraints = [IBLayoutConstraint]()
    private(set) var gestures = [IBGestureRecognizer]()
    private(set) var layoutGuides = [IBLayoutGuide]()
    private(set) var elementTree: String!//ex) attributedString->fragment->attributes->color
    
    var uniqueName: String? {
        didSet {
            for gesture in gestures {
                gesture.uniqueName = uniqueName
            }
        }
    }
    
    var waitingElementList = [String]() {
        didSet {
            var lastViewIndex: Int?
            for (i, element) in waitingElementList.reversed().enumerated() {
                if let _ = IBCompatibleViewType(rawValue: element) {
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
        .init(ib: "translatesAutoresizingMaskIntoConstraints", propertyName: "translatesAutoresizingMaskIntoConstraints", type: .bool),
        .init(ib: "autoresizingMask", propertyName: "autoresizingMask", type: .optionSet),
        .init(ib: "contentMode", propertyName: "contentMode", type: .enum),
        .init(ib: "frame", propertyName: "frame", type: .cgRect),
        .init(ib: "backgroundColor", propertyName: "backgroundColor", type: .color),
        .init(ib: "tintColor", propertyName: "tintColor", type: .color),
        .init(ib: "opaque", propertyName: "isOpaque", type: .bool),
        .init(ib: "tag", propertyName: "tag", type: .number),
        .init(ib: "highlighted", propertyName: "isHighlighted", type: .bool),
        .init(ib: "selected", propertyName: "isSelected", type: .bool),
        .init(propertyName: "semanticContentAttribute", type: .enum),
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
          ibCompatibleView: IBCompatibleViewType
    ) {
        guard let id = attributes["id"] else { return nil }
        self.id = id
        self.classType = ibCompatibleView
        self.dependencies = IBViewDependencies(ibCompatibleView: classType)
        self.customClass = attributes["customClass"]
        self.customModule = attributes["customModule"]
        super.init()
        self.mapping(attributes)
        
        if let userLabel = attributes["userLabel"] {
            let dropFirst = userLabel.dropFirst()
            let initial = userLabel.prefix(1).lowercased()
            let uniqueName = initial + dropFirst
            self.uniqueName = uniqueName.replacingOccurrences(of: " ", with: "")
        }
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
    
    func addValueToProperties(attributes: [String: String]) {
        switch elementTree {
        case "rect":
            guard let propertyName = attributes["key"] else { return }
            guard propertyName == "frame" else { return }
            guard let rect = IBRect(attributes: attributes) else { return }
            addValueToProperty(ib: propertyName, value: rect)
        case "autoresizingMask":
            guard let propertyName = attributes["key"],
                  let autoresizingMask = IBOptionSet(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: autoresizingMask)
        case "color":
            guard let propertyName = attributes["key"] else { return }
            guard let color = IBColor(attributes: attributes) else { return }
            addValueToProperty(ib: propertyName, value: color)
        case "constraints->constraint":
            guard let constraint = IBLayoutConstraint(attributes, parentViewID: id) else { return }
            constraints.append(constraint)
        case "viewLayoutGuide":
            layoutGuides.append(IBLayoutGuide(attributes: attributes))
        case "connections->outletCollection":
            guard let gesture = IBGestureRecognizer(attributes: attributes) else { return }
            gesture.uniqueName = uniqueName
            gestures.append(gesture)
        default:
            break
        }
    }
    
    @objc dynamic func generateSwiftCode() -> [Line] {
        guard let uniqueName = uniqueName else { return [] }
        return buildLines {
            let variableName = classType.variableName
            let className = customClass ?? classType.description
            Line(variableName: uniqueName, lineType: .declare(isMutating: false, type: className, operand: "{"))
            Line(variableName: variableName, lineType: .declare(isMutating: false, type: nil, operand: "\(className)()"))
            generateCustomizablePropertyLines(except: ["contentView"])
            generateBasicTypePropertyLines()
            generateNonCustomizablePropertyLines()
            generateFunctions()
            Line(relatedVariableName: variableName, custom: "return \(variableName)")
            Line(relatedVariableName: uniqueName, custom: "}()")
        }
    }
    
}

