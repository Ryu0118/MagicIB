import Foundation
import ArgumentParser
import MagicIBCore

@main
struct MagicIB: ParsableCommand {
    @Argument(help: "")
    var projectURL: String?
    
    @Argument(help: "")
    var ibURL: String?
    
    static let _commandName: String = "magicib"
    
    mutating func run() throws {
        let currentDirectory = FileManager.default.currentDirectoryPath
        let currentURL = URL(fileURLWithPath: currentDirectory)
        
        let url = URL(fileURLWithPath: projectURL ?? projectURL ?? "", relativeTo: currentURL)
        try generate(url: url)
        CFRunLoopRun()
    }
    
    private func generate(url: URL) throws {
        let fileFinder = IBFileSearcher(fileURLWithRoot: url)
        let allIBFiles = try fileFinder.getAllIBPaths()
        let parser = IBParser()
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)
        for file in allIBFiles {
            print(file)
            dispatchQueue.async(group: dispatchGroup) {
                try? parser.parse(file) { code in
                    // write
                    print(code)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print(allIBFiles)
            CFRunLoopStop(CFRunLoopGetCurrent())
        }
    }
}
