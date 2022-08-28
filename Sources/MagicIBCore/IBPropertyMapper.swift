//
//  IBPropertyMapping.swift
//  
//
//  Created by Ryu on 2022/07/30.
//

import Foundation

class IBPropertyMapper {
    let ib: String
    let propertyName: String
    let type: IBInspectableType
    var value: Any? {
        didSet {
            imageValidation()
            autoresizingMaskValidation()
            if propertyName == "lineBreakMode" {
                
            }
        }
    }
    
    var isRequireInitializer: Bool {
        switch type {
        case .font, .color, .cgRect, .image, .buttonConfiguration, .paragraphStyle, .optionSet:
            return true
        default:
            return false
        }
    }
    
    private var recursionLock = false
    
    init(ib: String, propertyName: String, type: IBInspectableType) {
        self.ib = ib
        self.propertyName = propertyName
        self.type = type
    }
    
    init(propertyName: String, type: IBInspectableType) {
        self.propertyName = propertyName
        self.ib = propertyName
        self.type = type
    }
    
    func addValue(_ value: Any?) {
        self.value = value
        if let object = value as? UniqueName {
            object.uniqueName = propertyName
        }
    }
    
    private func autoresizingMaskValidation() {
        guard var autoresizingMask = value as? IBOptionSet,
              type == .optionSet,
              propertyName == "autoresizingMask",
              !recursionLock
        else { return }
        autoresizingMask.swap(from: ".widthSizable", to: ".flexibleWidth")
        autoresizingMask.swap(from: ".heightSizable", to: ".flexibleHeight")
        autoresizingMask.swap(from: ".flexibleMaxX", to: ".flexibleRightMargin")
        autoresizingMask.swap(from: ".flexibleMaxY", to: ".flexibleBottomMargin")
        autoresizingMask.swap(from: ".flexibleMinX", to: ".flexibleLeftMargin")
        autoresizingMask.swap(from: ".flexibleMinY", to: ".flexibleTopMargin")
        recursionLock = true
        value = autoresizingMask
    }
    
    private func imageValidation() {
        guard let imageName = value as? String,
              let url = Bundle.module.url(forResource: "SFSymbols", withExtension: "txt"),
              let data = try? Data(contentsOf: url),
              let string = String(data: data, encoding: .utf8),
              type == .image
        else { return }
        let sfsymbols = string.components(separatedBy: "\n")
        if sfsymbols.contains(imageName) {
            value = IBImage(systemName: imageName)
        }
        else {
            value = IBImage(named: imageName)
        }
    }
}


