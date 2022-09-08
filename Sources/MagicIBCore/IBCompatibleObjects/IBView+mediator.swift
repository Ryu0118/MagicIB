//
//  IBViewProvider.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

import Foundation

extension IBView {
    
    static func instance(attributes: [String: String], ibCompatibleView: IBCompatibleViewType) -> IBView? {
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
        case .collectionView:
            return IBCollectionView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .stackView:
            return IBStackView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .segmentedControl:
            return IBSegmentedControl(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .slider:
            return IBSlider(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .switch:
            return IBSwitch(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .activityIndicatorView:
            return IBActivityIndicatorView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .pageControl:
            return IBPageControl(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .stepper:
            return IBStepper(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .collectionViewCell:
            return IBCollectionViewCell(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .textView:
            return IBTextView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .textField:
            return IBTextField(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .pickerView:
            return IBPickerView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .visualEffectView:
            return IBVisualEffectView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .mapView:
            return IBMapView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .searchBar:
            return IBSearchBar(attributes: attributes, ibCompatibleView: ibCompatibleView)
        case .wkWebView:
            return IBWebView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        default:
            return IBView(attributes: attributes, ibCompatibleView: ibCompatibleView)
        }
    }
}
