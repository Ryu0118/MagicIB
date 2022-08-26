//
//  IBSearchBar.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

class IBSearchBar: IBView, LongCharactersContainable {
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
        .init(propertyName: "searchTextPositionAdjustment", type: .offsetWrapper),
        .init(propertyName: "searchFieldBackgroundPositionAdjustment", type: .offsetWrapper),
        .init(propertyName: "autocapitalizationType", type: .enum),
        .init(propertyName: "autocorrectionType", type: .enum),
        .init(propertyName: "spellCheckingType", type: .enum),
        .init(propertyName: "keyboardType", type: .enum),
        .init(propertyName: "keyboardAppearance", type: .enum),
        .init(propertyName: "returnKeyType", type: .enum),
        .init(propertyName: "enablesReturnKeyAutomatically", type: .bool),
        .init(propertyName: "secureTextEntry", type: .bool),
        .init(propertyName: "smartDashesType", type: .enum),
        .init(propertyName: "smartInsertDeleteType", type: .enum),
        .init(propertyName: "smartQuotesType", type: .enum),
        .init(propertyName: "textContentType", type: .enum),
        .init(propertyName: "scopeButtonTitles", type: .array)
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + searchBarProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        
        switch elementTree {
        case "imageReference":
            guard let propertyName = attributes["key"],
                  let image = IBImage(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: image)
        case "offsetWrapper":
            guard let propertyName = attributes["key"],
                  let offset = IBOffset(attributes: attributes)
            else { return }
            addValueToProperty(ib: propertyName, value: offset)
        case "textInputTraits":
            mapping(attributes)
        default:
            break
        }
    }
    
    func handleLongCharacters(key: String?, characters: String) {
        if var array = self.scopeButtonTitles as? [String] {
            array.append(characters)
            addValueToProperty(ib: "scopeButtonTitles", value: array)
        }
        else {
            let array = [characters]
            addValueToProperty(ib: "scopeButtonTitles", value: array)
        }
    }
}
