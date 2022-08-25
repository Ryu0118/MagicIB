//
//  IBWebViewConfiguration.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

@dynamicMemberLookup
struct IBWebViewConfiguration: IBCompatibleObject {
    let properties: [IBPropertyMapper] = [
        .init(propertyName: "allowsAirPlayForMediaPlayback", type: .bool),
        .init(propertyName: "applicationNameForUserAgent", type: .string),
        .init(propertyName: "allowsInlineMediaPlayback", type: .bool),
        .init(propertyName: "allowsPictureInPictureMediaPlayback", type: .bool),
        .init(propertyName: "suppressesIncrementalRendering", type: .bool),
        .init(propertyName: "selectionGranularity", type: .enum),
        .init(propertyName: "dataDetectorTypes", type: .optionSet),
        .init(propertyName: "mediaTypesRequiringUserActionForPlayback", type: .optionSet),
        .init(propertyName: "preferences", type: .wkPreferences),
    ]
    
    init(attributes: [String: String]) {
        mapping(attributes)
    }
    
    subscript(dynamicMember key: String) -> Any? {
        findProperty(ib: key)?.value
    }
}
