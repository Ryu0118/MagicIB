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
    }
    
    private func generate(url: URL) throws {
        let fileFinder = IBFileSearcher(fileURLWithRoot: url)
        let allIBFiles = try fileFinder.getAllIBPaths()
        print(allIBFiles.map { $0.absoluteString }.joined(separator: "\n"))
        for file in allIBFiles {
            write(ibFile: file)
        }
    }
    
    private func write(ibFile: URL) {
        let parser = IBParser()
        let semaphore = DispatchSemaphore(value: 0)
        try? parser.parse(ibFile) { code in
            // write
            print(code ?? "")
            semaphore.signal()
        }
        semaphore.wait()
    }
}
