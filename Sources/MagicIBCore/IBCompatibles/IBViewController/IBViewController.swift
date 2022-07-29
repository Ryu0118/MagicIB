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
    let superClass: IBCompatibleViewController
    let dependencies: IBViewControllerDependencies
    
    var typeName: String {
        if let name = customClassName {
            return name
        }
        else {
            return superClass.description
        }
    }
    
    var ibViews = [IBView]()
    
    init?(attributes: [String: String],
          ibCompatibleViewController: IBCompatibleViewController
    ) {
        let converter = IBAttributeConverter(attributes)
        guard let id = converter.viewID else { return nil }
        self.id = id
        self.customClassName = converter.customClassName
        self.customModuleName = converter.customModuleName
        self.superClass = ibCompatibleViewController
        self.dependencies = IBViewControllerDependencies(ibCompatibleViewController: superClass)
    }
    
    func appendView(_ ibView: IBView) {
        ibViews.append(ibView)
    }
    
}
