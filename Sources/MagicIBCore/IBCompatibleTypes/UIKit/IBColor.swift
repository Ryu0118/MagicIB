//
//  IBColor.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation
import OpenGL

struct IBColor {
    // rgb
    private(set) var red: String?
    private(set) var green: String?
    private(set) var blue: String?
    //systemColor
    private(set) var systemColor: String?
    //name
    private(set) var name: String?
    
    init?(attributes: [String: String]) {
        //rgbColor
        if let red = attributes["red"],
           let green = attributes["green"],
           let blue = attributes["blue"] {
            self.red = red
            self.green = green
            self.blue = blue
        }
        //systemColor
        else if let systemColorName = attributes["systemColor"] {
            var systemColor = systemColorName
            if systemColorName.contains("Color") {
                let colorIndex = systemColor.index(systemColor.endIndex, offsetBy: -5)
                systemColor.remove(at: colorIndex) //ex) systemPurple
            }
            self.systemColor = systemColor
        }
        //name
        else if let name = attributes["name"] {
            self.name = name
        }
        else {
            return nil
        }
    }
}
