//
//  IBFileSearcher.swift
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
    
    func getAllIBPaths() -> [URL] {
        _getAllIBPaths(url: fileURLWithRoot)
    }
    
    private func _getAllIBPaths(url: URL, currentURLs: [URL] = []) -> [URL] {
        guard let contents = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else {
            if extensions.contains(url.pathExtension) {
                return [url]
            }
            return []
        }
        
        var urls = currentURLs
        
        for content in contents {
            if extensions.contains(content.pathExtension) {
                urls.append(content)
            }
            else if content.hasDirectoryPath {
                let directoryContent = _getAllIBPaths(url: content, currentURLs: urls)
                urls = directoryContent
            }
        }
        return urls
    }
    
}
