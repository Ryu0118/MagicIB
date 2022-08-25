//
//  IBViewControllerDependencies.swift
//  
//
//  Created by Ryu on 2022/07/29.
//

import Foundation

protocol Dependencies {
    var dependencies: [String] { get }
}

struct IBViewControllerDependencies: Dependencies {
    let ibCompatibleViewController: IBCompatibleViewController
    
    var dependencies: [String] {
        switch ibCompatibleViewController {
        case .glkViewController:
            return ["UIKit", "GLKit"]
        case .avPlayerViewController:
            return ["UIKit", "AVKit"]
        default:
            return ["UIKit"]
        }
    }
}
