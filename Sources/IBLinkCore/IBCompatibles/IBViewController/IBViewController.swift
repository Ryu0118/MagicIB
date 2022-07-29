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
    let ibViewControllerElement: IBViewControllerCompatibleElement
    let dependencies: IBViewControllerDependencies
    
    var typeName: String {
        if let name = customClassName {
            return name
        }
        else {
            return ibViewControllerElement.description
        }
    }
    
    var ibViews = [IBView]()
    
    init?(attributes: [String: String],
          ibViewControllerElement: IBViewControllerCompatibleElement
    ) {
        let converter = IBAttributeConverter(attributes)
        guard let id = converter.viewID else { return nil }
        self.id = id
        self.customClassName = converter.customClassName
        self.customModuleName = converter.customModuleName
        self.ibViewControllerElement = ibViewControllerElement
        self.dependencies = IBViewControllerDependencies(ibViewControllerCompatibleElement: ibViewControllerElement)
    }
    
    func appendView(_ ibView: IBView) {
        ibViews.append(ibView)
    }
    
}
