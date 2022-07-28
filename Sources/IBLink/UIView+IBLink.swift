//
//  UIView+IBLink.swift
//  
//
//  Created by Ryu on 2022/07/28.
//

#if canImport(UIKit)
import UIKit

extension UIView {
    
    var ambiguous: Bool {
        get { hasAmbiguousLayout }
        set { self.hasAmbiguousLayout = newValue }
    }
    
    var verticalHuggingPriority: NSLayoutPriority {
        get { contentHuggingPriority(for: .vertical) }
        set { let a = contentHuggingPriority(for: <#T##NSLayoutConstraint.Orientation#>) }
    }
    
}

#endif
