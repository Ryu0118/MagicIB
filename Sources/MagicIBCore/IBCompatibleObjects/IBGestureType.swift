//
//  IBGestureType.swift
//  
//
//  Created by Ryu on 2022/08/31.
//

import Foundation

enum IBGestureType {
    case tapGestureRecognizer
    case pinchGestureRecognizer
    case rotationGestureRecognizer
    case swipeGestureRecognizer(direction: String)
    case panGestureRecognizer(minimumNumberOfTouches: String)
    case screenEdgePanGestureRecognizer(minimumNumberOfTouches: String)
    case pongPressGestureRecognizer(allowableMovement: String, minimumPressDuration: String)
    
    init?(elementName: String, attributes: [String: String]) {
        switch elementName {
        case "tapGestureRecognizer":
            self = .tapGestureRecognizer
        case "pinchGestureRecognizer":
            self = .pinchGestureRecognizer
        case "rotationGestureRecognizer":
            self = .rotationGestureRecognizer
        case "swipeGestureRecognizer":
            guard let direction = attributes["direction"] else { return nil }
            self = .swipeGestureRecognizer(direction: direction)
        case "panGestureRecognizer":
            guard let minimumNumberOfTouches = attributes["minimumNumberOfTouches"] else { return nil }
            self = .panGestureRecognizer(minimumNumberOfTouches: minimumNumberOfTouches)
        case "screenEdgePanGestureRecognizer":
            guard let minimumNumberOfTouches = attributes["minimumNumberOfTouches"] else { return nil }
            self = .screenEdgePanGestureRecognizer(minimumNumberOfTouches: minimumNumberOfTouches)
        case "pongPressGestureRecognizer":
            guard let allowableMovement = attributes["allowableMovement"],
                  let minimumPressDuration = attributes["minimumPressDuration"]
            else { return nil }
            self = .pongPressGestureRecognizer(allowableMovement: allowableMovement, minimumPressDuration: minimumPressDuration)
        default:
            return nil
        }
    }
}
