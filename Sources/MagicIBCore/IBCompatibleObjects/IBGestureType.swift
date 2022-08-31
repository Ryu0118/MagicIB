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
}
