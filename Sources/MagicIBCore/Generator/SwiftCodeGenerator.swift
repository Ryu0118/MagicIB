//
//  SwiftCodeGenerator.swift
//  
//
//  Created by Ryu on 2022/08/21.
//

import Foundation

final class SwiftCodeGenerator {
    
    enum IBType {
        case storyboard(ibViewController: IBViewController)
        case xib(ibView: IBView)
    }
    
    let type: IBType
    let url: URL
    
    var fileName: String {
        className + ".swift"
    }
    
    var className: String {
        switch type {
        case .storyboard(_):
            return url
                .deletingPathExtension()
                .lastPathComponent
                .insert(last: "ViewController")
        case .xib(_):
            return url
                .deletingPathExtension()
                .lastPathComponent
        }
    }
    
    private var indentCount = 0
    
    init(url: URL, type: IBType) {
        self.type = type
        self.url = url
    }
    
    func generate() throws -> String {
        switch type {
        case .storyboard(let ibViewController):
            return try generateViewController(ibViewController: ibViewController)
        case .xib(let ibView):
            return generateView(ibView: ibView)
        }
    }
    
}

private extension SwiftCodeGenerator {
    func buildLines(@ArrayBuilder<Line> _ builder: () -> [Line]) -> [Line] {
        builder()
    }
    
    func generateImport(dependencies: [Dependencies]) -> [Line] {
        Set(dependencies.flatMap { $0.dependencies })
            .sorted()
            .map { Line(relatedVariableName: .import, custom: "import \($0)") }
    }
    
    func generateFileHeader() -> [Line] {
        """
        // \(fileName)
        //
        // This is a generated file.
        // Generated by MagicIB, see https://github.com/Ryu0118/MagicIB
        //
        """.buildLines(relatedVariableName: .fileHeader)
    }
    
    func generateSubviews(views: [IBView]) -> [Line] {
        views
            .assignName()
            .flatMap { uniqueName, view -> [Line] in
                view.uniqueName = uniqueName
                return view.generateSwiftCode() + [Line.newLine]
            }
    }
    
    func getAllViews(parentView: IBView) -> [IBView] {
        return parentView.subviews.findAllSubviews()
    }
    
    func generateConstraints(views: [IBView]) -> [Line] {
        //var constraints: [[IBLayoutConstraint]] = []
        let generator = ConstraintsGenerator(views: views)
        return generator.generateSwiftCode()
    }
}

//MARK: ViewController extension
private extension SwiftCodeGenerator {
    
    func generateViewController(ibViewController: IBViewController) throws -> String {
        guard let ibView = ibViewController.ibView else { throw "IBViewController property IBView is nil" }
        
        let dependencies: [Dependencies] = [ibViewController.dependencies] + ibViewController.ibView.subviews.compactMap { $0.dependencies }
        let inheritance = ibViewController.superClass.description
        let allViews = getAllViews(parentView: ibView)
        
        return buildLines {
            generateFileHeader()
            Line.newLine
            generateImport(dependencies: dependencies)
            Line.newLine
            Line(variableName: .class, lineType: .declareClass(name: className, inheritances: [inheritance]))
            Line.newLine
            generateSubviews(views: allViews)
            generateViewDidLoad()
            generateConstraints(views: allViews)
            Line.newLine
            Line.end
        }
        .calculateIndent()
        .joined(separator: "\n")
    }
    
    func generateViewDidLoad() -> [Line] {
        buildLines {
            Line(function: .init(name: "viewDidLoad", arguments: [], accessLevel: nil, isOverride: true))
            Line(variableName: "super", lineType: .function("super.viewDidLoad()"))
            Line.end
        }
    }
    
}

//MARK: View Extension
private extension SwiftCodeGenerator {
    
    func generateView(ibView: IBView) -> String {
        ""
    }
    
}

private extension Array where Element == Line {
    
    func calculateIndent() -> [String] {
        var indentCount = 0
        return self.map {
            if $0.isStartOfBlock {
                $0.indent(indentCount)
                indentCount += 1
            }
            else if $0.isEndOfBlock {
                indentCount -= 1
                $0.indent(indentCount)
            }
            else {
                $0.indent(indentCount)
            }
            return $0.line
        }
    }
    
}

private extension Array where Element == IBView {
    
    func assignName() -> [(String, IBView)] {
        var classTypeCounts = [IBCompatibleView: Int]()
        return self.map { view -> (String, IBView) in
            if let count = classTypeCounts[view.classType] {
                classTypeCounts.updateValue(count + 1, forKey: view.classType)
            }
            else {
                classTypeCounts.updateValue(0, forKey: view.classType)
            }
            
            guard let count = classTypeCounts[view.classType] else { fatalError() }
            
            if count == 0 {
                return (view.classType.variableName, view)
            }
            else {
                return (view.classType.variableName + "\(count)", view)
            }
        }
    }
    
    func findAllSubviews() -> [IBView] {
        guard !self.isEmpty else { return self }
        let arrangedSubviews = self
            .compactMap { view -> [IBView] in
                if let stackView = view as? IBStackView {
                    return stackView.arrangedSubviews
                }
                else {
                    return view.subviews
                }
            }
            .flatMap { $0 }
        return self + arrangedSubviews.findAllSubviews()
    }
    
}

private extension Array where Element == IBLayoutConstraint {
    func grouped() -> [[IBLayoutConstraint]] {
        var group: [[IBLayoutConstraint]] = []
        var tmp: [IBLayoutConstraint] = []
        var previousID: String?
        let sorted = self.sorted { $0.firstItem < $1.firstItem }
        
        for constraint in sorted {
            defer { previousID = constraint.firstItem }
            guard let previousID = previousID else { continue }
            if constraint.firstItem == previousID {
                tmp.append(constraint)
            }
            else {
                group.append(tmp)
                tmp = [constraint]
            }
        }
        return group
    }
}

private struct ConstraintsGenerator: SwiftCodeGeneratable {
    
    let constraints: [[IBLayoutConstraint]]
    let views: [IBView]
    
    init(views: [IBView]) {
        self.views = views
        self.constraints = views
            .flatMap { $0.constraints }
            .grouped()
    }
    
    func generateSwiftCode() -> [Line] {
        buildLines {
            for viewConstraints in constraints {
                viewConstraints
                    .generateSwiftCode()
                    .replaceIdToUniqueName(allViews: views, constraints: viewConstraints)
            }
        }
    }
    
}
