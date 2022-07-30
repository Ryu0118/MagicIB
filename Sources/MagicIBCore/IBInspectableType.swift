//
//  File.swift
//  
//
//  Created by Ryu on 2022/07/28.
//
#if os(macOS)
import Foundation

enum IBInspectableType: Equatable {
    case number
    case bool
    case `enum`
    case initializer
    case array
    case custom
}
#endif
