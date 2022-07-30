//
//  IBViewProvider.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

import Foundation

enum IBViewProvider {
    
    static func addValueToProperties(ibView: IBView, elementType: Any, attributes: [String: String]) {
        switch ibView.superClass {
        case .view, .imageView, .tableView, .label, .progressView, .collectionView, .stackView, .segmentedControl, .slider, .switch, .activityIndicatorView, .pageControl, .stepper, .tableViewCell, .collectionViewCell, .textView, .scrollView, .pickerView, .visualEffectView, .mapView, .mtkView, .glkView, .sceneKitView, .skView, .arskView, .arscnView, .wkWebView, .webView, .arView, .clLocationButton, .navigationBar, .toolbar, .tabBar, .searchBar, .containerView:
            guard let elementType = elementType as? IBView.IBElementType else { return }
            ibView.addValueToProperties(elementType: elementType, attributes: attributes)
        case .button:
            guard let elementType = elementType as? IBButton.IBElementType,
                  let ibButtonView = ibView as? IBButton
            else { return }
            ibButtonView.addValueToProperties(elementType: elementType, attributes: attributes)
//        case .tableView:
//            <#code#>
//        case .label:
//            <#code#>
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
//        case .scrollView:
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