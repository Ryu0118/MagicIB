//
//  IBViewControllerDependencies.swift
//  
//
//  Created by Ryu on 2022/07/29.
//

import Foundation

struct IBViewControllerDependencies {
    let ibViewControllerCompatibleElement: IBViewControllerCompatibleElement
    
    var dependencies: [String] {
        switch ibViewControllerCompatibleElement {
        case .glkViewController:
            return ["UIKit", "GLKit"]
        case .avPlayerViewController:
            return ["UIKit", "AVKit"]
        default:
            return ["UIKit"]
        }
    }
}
