//
//  Array+IBView.swift
//  
//
//  Created by Ryu on 2022/08/31.
//

import Foundation

extension Array where Element == IBView {
    func findAllSubviews() -> [IBView] {
        guard !self.isEmpty else { return self }
        let arrangedSubviews = self
            .compactMap { view -> [IBView] in
                if let stackView = view as? IBStackView {
                    return stackView.arrangedSubviews
                }
                else {
                    return view.subviews
                }
            }
            .flatMap { $0 }
        return self + arrangedSubviews.findAllSubviews()
    }
}
