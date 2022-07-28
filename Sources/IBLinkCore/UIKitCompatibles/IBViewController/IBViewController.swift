//
//  IBViewController.swift
//  
//
//  Created by Ryu on 2022/07/29.
//

import Foundation

class IBViewController: NSObject {
    let id: String
    let customClassName: String?
    let customModuleName: String?
    let ibViews = [IBView]()
    let ibViewControllerCompatibleElement: IBViewControllerCompatibleElement
    let dependencies: IBViewDependencies
    
    init(attributes: [String: String],
         ibViewControllerCompatibleElement: IBViewControllerCompatibleElement
    ) {
        
    }
    
}
