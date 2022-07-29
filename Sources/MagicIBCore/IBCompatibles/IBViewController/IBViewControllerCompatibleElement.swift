//
//  IBCompatibleViewController.swift
//  
//
//  Created by Ryu on 2022/07/29.
//

import Foundation

enum IBCompatibleViewController: String, CaseIterable, CustomStringConvertible {
    case viewController
    case tableViewController
    case glkViewController
    case navigationController
    case collectionViewController
    case splitViewController
    case tabBarController
    case avPlayerViewController
    
    var description: String {
        switch self {
        case .viewController:
            return "UIViewController"
        case .tableViewController:
            return "UITableViewController"
        case .glkViewController:
            return "GLKViewController"
        case .navigationController:
            return "UINavigationController"
        case .collectionViewController:
            return "UICollectionViewController"
        case .splitViewController:
            return "UISplitViewController"
        case .tabBarController:
            return "UITabBarController"
        case .avPlayerViewController:
            return "AVPlayerViewController"
        }
    }
}

