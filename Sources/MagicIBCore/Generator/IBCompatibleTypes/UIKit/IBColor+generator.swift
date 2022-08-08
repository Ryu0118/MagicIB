//
//  IBColor+generator.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

extension IBColor: IBSwiftSourceGeneratable {

    func generateSwiftCode() -> String? {
        if let red = self.red as? String,
           let green = self.green as? String,
           let blue = self.blue as? String,
           let alpha = self.alpha as? String {
            return "UIColor(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)"
        }
        else if let systemColor = self.systemColor as? String {
            return ".\(systemColor)"
        }
        else if let name = self.name as? String {
            return "UIColor(named: \"\(name)\")"
        }
        else {
            return nil
        }
     }
    
}
