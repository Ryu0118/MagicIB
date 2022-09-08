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
            colorValidation()
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
    
    private var enumMappers = [IBEnumMapper]() {
        didSet {
            valueValidation()
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
    
    func addEnumMappers(_ mapper: [IBEnumMapper]) {
        self.enumMappers += mapper
    }
    
    private func valueValidation() {
        guard let value = value as? String else { return }
        
        for enumMapper in enumMappers {
            guard enumMapper.from == value else { continue }
            self.value = enumMapper.to
        }
    }
    
    private func colorValidation() {
        guard let color = value as? IBColor,
              let systemColor = color.systemColor as? String,
              systemColor == "systemWhiteColor",
              type == .color,
              !recursionLock
        else { return }
        recursionLock = true
        value = IBColor(attributes: ["systemColor": "white"])
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
              type == .image
        else { return }
        let sfsymbols = SFSymbols.sfsymbols
        if sfsymbols.contains(imageName) {
            value = IBImage(systemName: imageName)
        }
        else {
            value = IBImage(named: imageName)
        }
    }
}
