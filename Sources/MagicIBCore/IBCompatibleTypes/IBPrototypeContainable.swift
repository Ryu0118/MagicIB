//
//  IBPrototypeContainable.swift
//  
//
//  Created by Ryu on 2022/08/05.
//

import Foundation

protocol IBPrototypeContainable where Self: IBScrollView {
    var prototypes: [IBCell] { get set }
}
