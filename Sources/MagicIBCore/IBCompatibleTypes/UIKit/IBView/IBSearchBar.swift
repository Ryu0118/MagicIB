//
//  IBSearchBar.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

struct IBOffset: IBCompatibleObject {
    let properties: [IBPropertyMapper] = [
        .init(propertyName: "horizontal", type: .number),
        .init(propertyName: "vertical", type: .number),
    ]
    init?(attributes: [String: String]) {
        mapping(attributes)
        if !isAllPropertiesActivated { return nil }
    }
}

class IBSearchBar: IBView {
    private let searchBarProperties: [IBPropertyMapper] = [
        .init(propertyName: "barStyle", type: .enum),
        .init(propertyName: "searchBarStyle", type: .enum),
        .init(propertyName: "text", type: .string),
        .init(propertyName: "prompt", type: .string),
        .init(propertyName: "placeholder", type: .string),
        .init(propertyName: "showsSearchResultsButton", type: .bool),
        .init(propertyName: "showsBookmarkButton", type: .bool),
        .init(propertyName: "showsCancelButton", type: .bool),
        .init(propertyName: "showsScopeBar", type: .bool),
        .init(propertyName: "backgroundImage", type: .image),
        .init(propertyName: "barTintColor", type: .color),
        .init(propertyName: "scopeBarBackgroundImage", type: .image),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + searchBarProperties
    }
}
/*
 <searchBar contentMode="center" semanticContentAttribute="forceLeftToRight" fixedFrame="YES" barStyle="black" searchBarStyle="minimal" text="1" prompt="3" placeholder="2" showsSearchResultsButton="YES" showsBookmarkButton="YES" showsCancelButton="YES" backgroundImage="screenshot.png" showsScopeBar="YES" translatesAutoresizingMaskIntoConstraints="NO" id="eId-eM-mWl">
     <rect key="frame" x="10" y="-34" width="414" height="132"/>
     <autoresizingMask key="autoresizingMask" widthSizable="YES" flexibleMaxY="YES"/>
     <color key="barTintColor" red="0.50640599590000002" green="1" blue="0.58250088099999997" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
     <imageReference key="scopeBarBackgroundImage" image="square.and.arrow.up.trianglebadge.exclamationmark" catalog="system" symbolScale="medium" renderingMode="template"/>
     <offsetWrapper key="searchTextPositionAdjustment" horizontal="6" vertical="5"/>
     <offsetWrapper key="searchFieldBackgroundPositionAdjustment" horizontal="10" vertical="10"/>
     <textInputTraits key="textInputTraits" autocapitalizationType="sentences" autocorrectionType="yes" spellCheckingType="yes" keyboardType="URL" keyboardAppearance="light" returnKeyType="route" enablesReturnKeyAutomatically="YES" secureTextEntry="YES" smartDashesType="yes" smartInsertDeleteType="no" smartQuotesType="yes" textContentType="name"/>
     <scopeButtonTitles>
         <string>Title</string>
         <string>Title</string>
     </scopeButtonTitles>
 </searchBar>
 */
