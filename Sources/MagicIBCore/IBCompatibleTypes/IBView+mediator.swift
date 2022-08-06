//
//  IBViewProvider.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

import Foundation

extension IBView {
    
    static func instance(attributes: [String: String], ibCompatibleView: IBCompatibleView) -> IBView? {
        switch ibCompatibleView {
        case .view:
            return IBView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .button:
            return IBButton(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .imageView:
            return IBImageView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .tableView:
            return IBTableView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .label:
            return IBLabel(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .scrollView:
            return IBScrollView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .tableViewCell:
            return IBTableViewCell(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .progressView:
            return IBProgressView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        default:
            return IBView(attributes: attributes, ibCompatibleView: ibCompatibleView)
//        case .progressView:
//            <#code#>
//        case .collectionView:
//            <#code#>
//        case .stackView:
//            <#code#>
//        case .segmentedControl:
//            <#code#>
//        case .slider:
//            <#code#>
//        case .switch:
//            <#code#>
//        case .activityIndicatorView:
//            <#code#>
//        case .pageControl:
//            <#code#>
//        case .stepper:
//            <#code#>
//        case .tableViewCell:
//            <#code#>
//        case .collectionViewCell:
//            <#code#>
//        case .textView:
//            <#code#>
//        case .pickerView:
//            <#code#>
//        case .visualEffectView:
//            <#code#>
//        case .mapView:
//            <#code#>
//        case .mtkView:
//            <#code#>
//        case .glkView:
//            <#code#>
//        case .sceneKitView:
//            <#code#>
//        case .skView:
//            <#code#>
//        case .arskView:
//            <#code#>
//        case .arscnView:
//            <#code#>
//        case .wkWebView:
//            <#code#>
//        case .webView:
//            <#code#>
//        case .arView:
//            <#code#>
//        case .clLocationButton:
//            <#code#>
//        case .navigationBar:
//            <#code#>
//        case .toolbar:
//            <#code#>
//        case .tabBar:
//            <#code#>
//        case .searchBar:
//            <#code#>
//        case .containerView:
//            <#code#>
        }
    }
}
