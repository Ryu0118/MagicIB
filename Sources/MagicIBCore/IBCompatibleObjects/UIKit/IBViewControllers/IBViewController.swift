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
    
    var ibView: IBView!
    
    init?(attributes: [String: String],
          ibCompatibleViewController: IBCompatibleViewController
    ) {
        guard let id = attributes["id"] else { return nil }
        self.id = id
        self.customClassName = attributes["customClass"]
        self.customModuleName = attributes["customModule"]
        self.superClass = ibCompatibleViewController
        self.dependencies = IBViewControllerDependencies(ibCompatibleViewController: superClass)
    }

}
