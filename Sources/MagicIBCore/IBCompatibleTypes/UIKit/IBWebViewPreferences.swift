//
//  IBWebViewPreferences.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

struct IBWebViewPreferences: IBCompatibleObject {
    let properties: [IBPropertyMapper] = [
        .init(propertyName: "javaScriptCanOpenWindowsAutomatically", type: .bool),
        .init(propertyName: "javaScriptEnabled", type: .bool),
        .init(propertyName: "minimumFontSize", type: .number),
    ]
    
    init(attributes: [String: String]) {
        mapping(attributes)
    }
}
