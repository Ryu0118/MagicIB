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

        for file in allIBFiles {
            try write(ibFile: file)
        }
    }
    
    private func write(ibFile: URL) throws {
        let parser = IBParser()
        let semaphore = DispatchSemaphore(value: 0)
        try parser.parse(ibFile) { code in
            if let code = code {
                let writePath = getWritePath(ibFile: ibFile)
                try? code.write(to: writePath, atomically: true, encoding: .utf8)
            }
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    private func getWritePath(ibFile: URL) -> URL {
        var mutating = ibFile.deletingPathExtension()
        mutating.appendPathExtension("swift")
        return mutating
    }
}
