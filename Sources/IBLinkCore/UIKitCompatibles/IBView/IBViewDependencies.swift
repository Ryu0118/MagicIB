//
//  IBViewDependencies.swift
//  
//
//  Created by Ryu on 2022/07/29.
//

import Foundation

struct IBViewDependencies {
    let ibViewCompatibleElement: IBViewCompatibleElement
    
    var dependencies: [String] {
        switch ibViewCompatibleElement {
        case .mapView:
            return ["UIKit", "MapKit"]
        case .mtkView:
            return ["UIKit", "MetalKit"]
        case .glkView:
            return ["UIKit", "GLKit"]
        case .sceneKitView:
            return ["UIKit", "SceneKit"]
        case .skView:
            return ["UIKit", "SpriteKit"]
        case .arskView, .arscnView:
            return ["UIKit", "ARKit"]
        case .wkWebView:
            return ["UIKit", "WebKit"]
        case .arView:
            return ["UIKit", "RealityKit"]
        case .clLocationButton:
            return ["UIKit", "CoreLocation"]
        default:
            return ["UIKit"]
        }
    }
}
