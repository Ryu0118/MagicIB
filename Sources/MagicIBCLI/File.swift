//
//  File.swift
//  
//
//  Created by Ryu on 2022/09/04.
//

import Foundation

struct IBFileSearcher {
    let fileURLWithRoot: URL
    
    private let extensions = ["xib", "storyboard"]
    
    init(fileURLWithRoot: URL) {
        self.fileURLWithRoot = fileURLWithRoot
        
    }
    
    func getAllIBPaths() throws -> [URL] {
        try _getAllIBPaths(url: fileURLWithRoot)
    }
    
    private func _getAllIBPaths(url: URL, currentURLs: [URL] = []) throws -> [URL] {
        let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        var urls = currentURLs
        for content in contents {
            if extensions.contains(content.pathExtension) {
                urls.append(content)
            }
            else if content.hasDirectoryPath {
                let directoryContent = try getContents(url: url, currentURLs: urls)
                urls.append(contentsOf: directoryContent)
            }
        }
        return urls
    }
    
}
