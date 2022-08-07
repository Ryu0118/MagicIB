//
//  IBSwiftSourceGeneratable.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

protocol IBSwiftSourceGeneratable {
    func generateSwiftCode() -> String?
}
