//
//  UIView+IBLink.swift
//  
//
//  Created by Ryu on 2022/07/28.
//

#if os(iOS)
import UIKit

extension UIView {
    
    var ambiguous: Bool {
        get { hasAmbiguousLayout }
        set { self.hasAmbiguousLayout = newValue }
    }
    
    var verticalHuggingPriority: Float {
        get { contentHuggingPriority(for: .vertical).rawValue }
        set { setContentHuggingPriority(.init(rawValue: newValue), for: .vertical) }
    }
    
    var horizontalHuggingPriority: Float {
        get { contentHuggingPriority(for: .horizontal) }
        set { setContentHuggingPriority(.init(rawValue: newValue), for: .vertical) }
    }
    
}

#endif
