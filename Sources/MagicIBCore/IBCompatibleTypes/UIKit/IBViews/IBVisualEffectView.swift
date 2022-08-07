//
//  Provides a blurred background, and renders contained views with vibrancy effects..swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

class IBVisualEffectView: IBView {
    private let visualEffectViewProperties: [IBPropertyMapper] = [
        .init(propertyName: "contentView", type: .view),
        .init(propertyName: "effect", type: .visualEffect)
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + visualEffectViewProperties
    }
    
    override func addValueToProperties(attributes: [String : String]) {
        super.addValueToProperties(attributes: attributes)
        
        switch elementTree {
        case "view->rect":
            guard let propertyName = attributes["key"],
                  let contentView = findProperty(ib: "contentView")?.value as? IBView,
                  let rect = IBRect(attributes: attributes)
            else { return }
            contentView.addValueToProperty(ib: propertyName, value: rect)
        case "view->autoresizingMask":
            guard let propertyName = attributes["key"],
                  let contentView = findProperty(ib: "contentView")?.value as? IBView,
                  let autoresizingMask = IBOptionSet(attributes: attributes)
            else { return }
            contentView.addValueToProperty(ib: propertyName, value: autoresizingMask)
        case "vibrancyEffect":
            let effect = IBVibrancyEffect(attributes: attributes)
            addValueToProperty(ib: "effect", value: effect)
        case "vibrancyEffect->blurEffect":
            guard let vibrancyEffect = findProperty(ib: "effect")?.value as? IBVibrancyEffect else { return }
            let blurEffect = IBBlurEffect(attributes: attributes)
            vibrancyEffect.addValueToProperty(ib: "blurEffect", value: blurEffect)
        case "blurEffect":
            let blurEffect = IBBlurEffect(attributes: attributes)
            addValueToProperty(ib: "effect", value: blurEffect)
        default:
            break
        }
    }
}
