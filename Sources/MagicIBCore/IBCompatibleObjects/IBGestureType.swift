//
//  IBGestureType.swift
//  
//
//  Created by Ryu on 2022/08/31.
//

import Foundation

enum IBGestureType {
    case tapGestureRecognizer(id: String)
    case pinchGestureRecognizer(id: String)
    case rotationGestureRecognizer(id: String)
    case swipeGestureRecognizer(id: String, direction: String)
    case panGestureRecognizer(id: String, minimumNumberOfTouches: String)
    case screenEdgePanGestureRecognizer(id: String, minimumNumberOfTouches: String)
    case pongPressGestureRecognizer(id: String, allowableMovement: String, minimumPressDuration: String)
    
    var id: String {
        switch self {
        case .tapGestureRecognizer(let id):
            return id
        case .pinchGestureRecognizer(let id):
            return id
        case .rotationGestureRecognizer(let id):
            return id
        case .swipeGestureRecognizer(let id, _):
            return id
        case .panGestureRecognizer(let id, _):
            return id
        case .screenEdgePanGestureRecognizer(let id, _):
            return id
        case .pongPressGestureRecognizer(let id, _, _):
            return id
        }
    }
    
    var variableName: String {
        switch self {
        case .tapGestureRecognizer(_):
            return "tapGestureRecognizer"
        case .pinchGestureRecognizer(_):
            return "pinchGestureRecognizer"
        case .rotationGestureRecognizer(_):
            return "rotationGestureRecognizer"
        case .swipeGestureRecognizer(_, _):
            return "swipeGestureRecognizer"
        case .panGestureRecognizer(_, _):
            return "panGestureRecognizer"
        case .screenEdgePanGestureRecognizer(_, _):
            return "screenEdgePanGestureRecognizer"
        case .pongPressGestureRecognizer(_, _, _):
            return "longPressGestureRecognizer"
        }
    }
    
    var className: String {
        switch self {
        case .tapGestureRecognizer(_):
            return "UITapGestureRecognizer"
        case .pinchGestureRecognizer(_):
            return "UIPinchGestureRecognizer"
        case .rotationGestureRecognizer(_):
            return "UIRotationGestureRecognizer"
        case .swipeGestureRecognizer(_, _):
            return "UISwipeGestureRecognizer"
        case .panGestureRecognizer(_, _):
            return "UIPanGestureRecognizer"
        case .screenEdgePanGestureRecognizer(_, _):
            return "UIScreenEdgePanGestureRecognizer"
        case .pongPressGestureRecognizer(_, _, _):
            return "UILongPressGestureRecognizer"
        }
    }
    
    var functionName: String {
        switch self {
        case .tapGestureRecognizer(_):
            return "tapGesture"
        case .pinchGestureRecognizer(_):
            return "pinchGesture"
        case .rotationGestureRecognizer(_):
            return "rotationGesture"
        case .swipeGestureRecognizer(_, let direction):
            return "\(direction)SwipeGesture"
        case .panGestureRecognizer(_, _):
            return "panGesture"
        case .screenEdgePanGestureRecognizer(_, _):
            return "screenEdgePanGesture"
        case .pongPressGestureRecognizer(_, _, _):
            return "longPressGesture"
        }
    }
    
    init?(elementName: String, attributes: [String: String]) {
        guard let id = attributes["id"] else { return nil }
        switch elementName {
        case "tapGestureRecognizer":
            self = .tapGestureRecognizer(id: id)
        case "pinchGestureRecognizer":
            self = .pinchGestureRecognizer(id: id)
        case "rotationGestureRecognizer":
            self = .rotationGestureRecognizer(id: id)
        case "swipeGestureRecognizer":
            guard let direction = attributes["direction"] else { return nil }
            self = .swipeGestureRecognizer(id: id, direction: direction)
        case "panGestureRecognizer":
            guard let minimumNumberOfTouches = attributes["minimumNumberOfTouches"] else { return nil }
            self = .panGestureRecognizer(id: id, minimumNumberOfTouches: minimumNumberOfTouches)
        case "screenEdgePanGestureRecognizer":
            guard let minimumNumberOfTouches = attributes["minimumNumberOfTouches"] else { return nil }
            self = .screenEdgePanGestureRecognizer(id: id, minimumNumberOfTouches: minimumNumberOfTouches)
        case "pongPressGestureRecognizer":
            guard let allowableMovement = attributes["allowableMovement"],
                  let minimumPressDuration = attributes["minimumPressDuration"]
            else { return nil }
            self = .pongPressGestureRecognizer(id: id, allowableMovement: allowableMovement, minimumPressDuration: minimumPressDuration)
        default:
            return nil
        }
    }
}
