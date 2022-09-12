//
//  ZeroDiscriminable.swift
//  
//
//  Created by Ryu on 2022/08/25.
//

import Foundation

protocol ZeroDiscriminable: IBCompatibleObject, SwiftGeneratable {
    var isZero: Bool { get }
    static var zero: Self? { get }
}
