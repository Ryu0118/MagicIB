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
    let ibVCElement: IBViewControllerCompatibleElement
    let dependencies: IBViewControllerDependencies
    
    var ibViews = [IBView]()
    
    init?(attributes: [String: String],
          ibVCElement: IBViewControllerCompatibleElement
    ) {
        let converter = IBAttributeConverter(attributes)
        guard let id = converter.viewID else { return nil }
        self.customClassName = converter.customClassName
        self.customModuleName = converter.customModuleName
        self.ibVCElement = ibVCElement
        self.dependencies = IBViewControllerDependencies(ibViewControllerCompatibleElement: ibVCElement)
    }
    
    func appendView(_ ibView: IBView) {
        ibViews.append(ibView)
    }
    
}
