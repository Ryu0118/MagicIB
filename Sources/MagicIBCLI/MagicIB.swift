import Foundation
import ArgumentParser
import MagicIBCore

@main
struct MagicIB: ParsableCommand {
    @Argument(help: "The root directory of the project containing the IB files you want to convert to Swift")
    var projectPath: String?
    
    @Argument(help: "Path of the Interface builder file you want to convert to Swift")
    var ibPath: String?
    
    @Option(name: .shortAndLong, help: "Output directory for files converted to Swift")
    var outputDir: String?
    
    static let _commandName: String = "magicib"
    
    mutating func run() throws {
        let currentDirectory = FileManager.default.currentDirectoryPath
        let currentURL = URL(fileURLWithPath: currentDirectory)
        
        let url = URL(fileURLWithPath: projectPath ?? projectPath ?? "", relativeTo: currentURL)
        try mkdirIfNeeded()
        generate(url: url)
    }
    
    func validate() throws {
        if ibPath == nil && projectPath == nil {
            throw ValidationError("Arguments not entered")
        }
    }
    
    private func generate(url: URL) {
        let fileFinder = IBFileSearcher(fileURLWithRoot: url)
        let allIBFiles = fileFinder.getAllIBPaths()
        
        guard !allIBFiles.isEmpty else {
            print("Could not find Interface Builder file")
            return
        }
        
        for file in allIBFiles {
            do {
                try write(ibFile: file)
            }
            catch {
                print("An error has occurred: \(error.localizedDescription)")
            }
        }
    }
    
    private func write(ibFile: URL) throws {
        let parser = IBParser()
        let semaphore = DispatchSemaphore(value: 0)
        print("Generating swift code from \(ibFile.lastPathComponent)")
        try parser.parse(ibFile) { code in
            defer { semaphore.signal() }
            
            guard let code = code else {
                print("Failed to generate Swift code, please add a UI component and run again")
                return
            }
            
            let writePath = getWritePath(ibFile: ibFile)
            do {
                try code.write(to: writePath, atomically: true, encoding: .utf8)
                print("Successfully generated \(writePath.lastPathComponent)")
            }
            catch {
                print("Failed to generate \(writePath.lastPathComponent)")
            }
        }
        semaphore.wait()
    }
    
    private func getWritePath(ibFile: URL) -> URL {
        if let outputDir = outputDir {
            let currentDirectory = FileManager.default.currentDirectoryPath
            let currentURL = URL(fileURLWithPath: currentDirectory)
            var outputURL = URL(fileURLWithPath: outputDir, relativeTo: currentURL)
            outputURL.appendPathComponent(ibFile.deletingPathExtension().lastPathComponent)
            outputURL.deletePathExtension()
            outputURL.appendPathExtension("swift")
            return outputURL
        }
        else {
            var mutating = ibFile.deletingPathExtension()
            mutating.appendPathExtension("swift")
            return mutating
        }
    }
    
    private func mkdirIfNeeded() throws {
        guard let outputDir = outputDir else {
            return
        }
        let currentDirectory = FileManager.default.currentDirectoryPath
        let currentURL = URL(fileURLWithPath: currentDirectory)
        let outputURL = URL(fileURLWithPath: outputDir, relativeTo: currentURL)
        try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)
    }
}
