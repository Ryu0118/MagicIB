//
//  IBColor+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBColor: IBSwiftSourceGeneratable {

    func generateSwiftCode() -> String? {
        if let red = findProperty(ib: "red")?.value as? String,
           let green = findProperty(ib: "green")?.value as? String,
           let blue = findProperty(ib: "blue")?.value as? String,
           let alpha = findProperty(ib: "alpha")?.value as? String {
            return "UIColor(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)"
        }
        else if let systemColor = findProperty(ib: "systemColor")?.value as? String {
            return ".\(systemColor)"
        }
        else if let name = findProperty(ib: "name")?.value as? String {
            return "UIColor(named: \"\(name)\")"
        }
        else {
            return nil
        }
     }
    
}
