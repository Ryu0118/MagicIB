//
//  IBSwiftSourceGeneratable.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

protocol SwiftGeneratable {
    func generateSwiftCode() -> [Line]
    func buildLines(@ArrayBuilder<Line> _ builder: () -> [Line]) -> [Line]
}

extension SwiftGeneratable {
    func buildLines(@ArrayBuilder<Line> _ builder: () -> [Line]) -> [Line] {
        builder()
    }
    
    func generateFunction(
        name: String,
        isFailable: Bool = false,
        isOverride: Bool = false,
        isInit: Bool = false,
        arguments: [Line.LineType.Argument] = [],
        accessLevel: String? = nil,
        @ArrayBuilder<Line> component builder: () -> [Line]
    ) -> [Line]
    {
        buildLines {
            if isInit {
                Line(initializer: .init(arguments: arguments, accessLevel: accessLevel, isFailable: isFailable, isOverride: isOverride))
                builder()
                Line.end
            }
            else {
                Line(function: .init(name: name, arguments: arguments, accessLevel: accessLevel, isOverride: isOverride))
                builder()
                Line.end
            }
        }
    }
}
