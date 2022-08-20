//
//  IBSwiftSourceGeneratable.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

protocol SwiftCodeGeneratable {
    func generateSwiftCode() -> [Line]
    func buildLines(@ArrayBuilder<Line> _ builder: () -> [Line]) -> [Line]
}

extension SwiftCodeGeneratable {
    func buildLines(@ArrayBuilder<Line> _ builder: () -> [Line]) -> [Line] {
        builder()
    }
}

extension SwiftCodeGeneratable {
    func camelized(_ source1: String, _ source2: String) -> String {
        let dropped = source2.dropFirst()
        let initial = source2.prefix(1).uppercased()
        return initial + dropped
    }
}
