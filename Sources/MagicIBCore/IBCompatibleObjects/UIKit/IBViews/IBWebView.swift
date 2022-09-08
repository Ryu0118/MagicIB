//
//  IBWebView.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

class IBWebView: IBView {
    private let webViewProperties: [IBPropertyMapper] = [
        .init(propertyName: "allowsBackForwardNavigationGestures", type: .bool),
        .init(propertyName: "allowsLinkPreview", type: .bool),
        .init(propertyName: "customUserAgent", type: .string),
        .init(propertyName: "configuration", type: .wkWebViewConfiguration) //getter
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + webViewProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        guard let propertyName = attributes["key"] else { return }
        switch elementTree {
        case "wkWebViewConfiguration":
            let configuration = IBWebViewConfiguration(attributes: attributes)
            addValueToProperty(ib: propertyName, value: configuration)
        case "wkWebViewConfiguration->dataDetectorTypes", "wkWebViewConfiguration->audiovisualMediaTypes":
            guard let configuration = self.configuration as? IBWebViewConfiguration,
                  let optionSet = IBOptionSet(attributes: attributes)
            else { return }
            configuration.addValueToProperty(ib: propertyName, value: optionSet)
        case "wkWebViewConfiguration->wkPreferences":
            guard let configuration = self.configuration as? IBWebViewConfiguration else { return }
            let preferences = IBWebViewPreferences(attributes: attributes)
            configuration.addValueToProperty(ib: propertyName, value: preferences)
        default:
            break
        }
    }
}
