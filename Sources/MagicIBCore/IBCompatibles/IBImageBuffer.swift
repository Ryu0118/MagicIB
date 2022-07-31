//
//  IBImageBuffer.swift
//  
//
//  Created by Ryu on 2022/07/31.
//
#if os(macOS)
import Foundation

class IBImageBuffer {
    struct Meta {
        let width: String
        let height: String
        let catalog: String?
    }
    
    static let shared = IBImageBuffer()
    private init {}
    
    var imageNames = [String: Meta?]()
    
    func append(_ imageName: String) {
        imageNames.updateValue(nil, forKey: imageName)
    }
    
    func append(_ meta: Meta, imageName: String) {
        imageNames[imageName] = meta
    }
    
    func generateSwiftCode(imageName: String) -> String? {
        guard let meta = imageNames[imageName] else { return nil }
        if let catalog = meta?.catalog, catalog == "system" {
            return "UIImage(systemName: \(imageName))"
        }
        else {
            return "UIImage(named: \(imageName))"
        }
    }
    
}
#endif
