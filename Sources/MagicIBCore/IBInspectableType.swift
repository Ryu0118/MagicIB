//
//  IBInspectableType.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

enum IBInspectableType {
    case number
    case bool
    case `enum`//or static let
    case array
    case color
    case cgRect
    case image
    case configuration
}
#endif
