//
//  SwiftCodeGenerator.swift
//  
//
//  Created by Ryu on 2022/08/21.
//

import Foundation

final class SwiftCodeGenerator {
    
    enum IBType {
        case storyboard(ibViewControllers: [IBViewController])
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
        case .storyboard(let ibViewControllers):
            return generateViewController(ibViewControllers: ibViewControllers)
        case .xib(let ibView):
            return generateView(ibView: ibView)
        }
    }
    
}

//MARK: ViewController extension
private extension SwiftCodeGenerator {
    
    func generateViewController(ibViewControllers: [IBViewController]) -> String {
        
        buildLines {
            generateFileHeader()
            Line.newLine
            generateImport(ibViewControllers: ibViewControllers)
            
            for ibViewController in ibViewControllers {
                if let ibView = ibViewController.ibView {
                    let inheritance = ibViewController.superClass.description
                    let allViews = getAllViews(parentView: ibView)
                    let className = ibViewController.customClassName ?? className
                    let gestures = generateAddGestureRecognizer(views: [ibView] + allViews)
                    
                    Line.newLine
                    Line(variableName: .class, lineType: .declareClass(name: className, inheritances: [inheritance]))
                    Line.newLine
                    generateSubviews(views: allViews)
                    generateViewDidLoad(setupGesture: !gestures.isEmpty)
                    Line.newLine
                    generateSetupViews(views: [ibView] + allViews)
                    Line.newLine
                    generateConstraints(views: [ibView] + allViews)
                    Line.newLine
                    gestures
                    Line.newLine
                    generateGestureObjcFunc(views: [ibView] + allViews)
                    Line.newLine
                    Line.end
                }
            }
        }
        .calculateIndent()
        .joined(separator: "\n")
        
    }
    
    func generateViewDidLoad(setupGesture: Bool) -> [Line] {
        generateFunction(name: "viewDidLoad", isOverride: true, arguments: [], accessLevel: nil) {
            Line(variableName: "super", lineType: .function("super.viewDidLoad()"))
            Line(variableName: "self", lineType: .function("setupViews()"))
            Line(variableName: "self", lineType: .function("setupConstraints()"))
            if setupGesture {
                Line(variableName: "self", lineType: .function("setupGestureRecognizers()"))
            }
        }
    }
    
}

//MARK: View Extension
private extension SwiftCodeGenerator {
    
    func generateView(ibView: IBView) -> String {
        buildLines {
            generateFileHeader()
            Line.newLine
            generateImport(parentView: ibView)
            
            let inheritance = ibView.classType.description
            let allViews = self.getAllViews(parentView: ibView)
            let className = ibView.customClass ?? self.className
            let gestures = generateAddGestureRecognizer(views: [ibView] + allViews)
            
            Line.newLine
            Line(variableName: .class, lineType: .declareClass(name: className, inheritances: [inheritance]))
            Line.newLine
            generateSubviews(views: allViews)
            generateInitializer(setupGesture: !gestures.isEmpty)
            Line.newLine
            generateSetupViews(views: [ibView] + allViews)
            Line.newLine
            generateConstraints(views: [ibView] + allViews)
            Line.newLine
            gestures
            Line.newLine
            generateGestureObjcFunc(views: [ibView] + allViews)
            Line.end
        }
        .calculateIndent()
        .joined(separator: "\n")
    }
    
    func generateInitializer(setupGesture: Bool) -> [Line] {
        buildLines {
            generateFunction(name: "", isOverride: true, isInit: true, arguments: [.init(argumentName: "frame", argumentType: "CGRect")]) {
                Line(variableName: "super", lineType: .function("super.init(frame: frame)"))
                Line(variableName: "self", lineType: .function("setupViews()"))
                Line(variableName: "self", lineType: .function("setupConstraints()"))
                if setupGesture {
                    Line(variableName: "self", lineType: .function("setupGestureRecognizers()"))
                }
            }
            Line.newLine
            """
            required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
            }
            """.buildLines(relatedVariableName: .initializer)
        }
    }
    
}

//MARK: Private functions
private extension SwiftCodeGenerator {
    func buildLines(@ArrayBuilder<Line> _ builder: () -> [Line]) -> [Line] {
        builder()
    }
    
    func generateFunction(
        name: String,
        isOverride: Bool = false,
        isInit: Bool = false,
        arguments: [Line.LineType.Argument] = [],
        accessLevel: String? = nil,
        @ArrayBuilder<Line> component builder: () -> [Line]
    ) -> [Line]
    {
        buildLines {
            if isInit {
                Line(initializer: .init(arguments: arguments, accessLevel: accessLevel, isOverride: isOverride))
                builder()
                Line.end
            }
            else {
                Line(function: .init(name: name, arguments: arguments, accessLevel: accessLevel, isOverride: isOverride))
                builder()
                Line.end
            }
        }
    }
    
    func generateImport(ibViewControllers: [IBViewController]) -> [Line] {
        let dependencies: [Dependencies] = ibViewControllers.compactMap { $0.dependencies } + ibViewControllers.compactMap { $0.ibView.dependencies } +
        ibViewControllers.flatMap { $0.ibView.subviews.findAllSubviews().map { $0.dependencies } }
        return Set(dependencies.flatMap { $0.dependencies })
            .sorted()
            .map { Line(relatedVariableName: .import, custom: "import \($0)") }
    }
    
    func generateImport(parentView: IBView) -> [Line] {
        let dependencies: [Dependencies] = parentView.subviews.findAllSubviews().compactMap { $0.dependencies } + [parentView.dependencies]
        return Set(dependencies.flatMap { $0.dependencies })
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
            .exceptCell()
            .flatMap { view in
                return view.generateSwiftCode() + [Line.newLine]
            }
    }
    
    func getAllViews(parentView: IBView) -> [IBView] {
        return parentView
            .subviews
            .findAllSubviews()
            .exceptCell()
            .assignName()
            .map { uniqueName, view -> IBView in
                view.uniqueName = uniqueName
                return view
            }
    }
    
    func generateConstraints(views: [IBView]) -> [Line] {
        //var constraints: [[IBLayoutConstraint]] = []
        generateFunction(name: "setupConstraints", accessLevel: "private") {
            let generator = ConstraintsGenerator(views: views)
            generator.generateSwiftCode()
        }
    }
    
    func generateSetupViews(views: [IBView]) -> [Line] {
        generateFunction(name: "setupViews", accessLevel: "private") {
            views.compactMap { view -> [Line]? in
                let uniqueName = view.uniqueName ?? "view"
                let excepted = view.subviews.exceptCell()
                if !excepted.isEmpty {
                    return excepted.map { subview -> Line in
                        guard let subviewUniqueName = subview.uniqueName else { fatalError("uniqueName has not been assigned")}
                        return Line(variableName: uniqueName, lineType: .function("\(uniqueName).addSubview(\(subviewUniqueName))"))
                    }
                }
                else if let stackView = view as? IBStackView,
                        !stackView.arrangedSubviews.isEmpty
                {
                    return stackView.arrangedSubviews.map { subview -> Line in
                        guard let subviewUniqueName = subview.uniqueName else { fatalError("uniqueName has not been assigned")}
                        return Line(variableName: uniqueName, lineType: .function("\(uniqueName).addArrangedSubview(\(subviewUniqueName))"))
                    }
                }
                else {
                    return nil
                }
            }
            .flatMap { $0 }
        }
        
    }
    
    func generateAddGestureRecognizer(views: [IBView]) -> [Line] {
        let lines = views.enumerated().flatMap { viewIndex, view -> [Line] in
            return view.gestures.enumerated().flatMap { gestureIndex, gesture -> [Line] in
                if viewIndex == views.count - 1 && gestureIndex == view.gestures.count - 1 {
                    return gesture.generateSwiftCode()
                }
                return gesture.generateSwiftCode() + [Line.newLine]
            }
        }
        
        guard !lines.isEmpty else { return [] }
        
        return generateFunction(name: "setupGestureRecognizers") {
            lines
        }
    }
    
    func generateGestureObjcFunc(views: [IBView]) -> [Line] {
        buildLines {
            for (viewIndex, view) in views.enumerated() {
                for (gestureIndex, gesture) in view.gestures.enumerated() {
                    gesture.generateObjcFunction()
                    if !(viewIndex == views.count - 1 && gestureIndex == view.gestures.count - 1) {
                        Line.newLine
                    }
                }
            }
        }
    }
}

//MARK: ConstraintsGenerator
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
            for (index, viewConstraints) in constraints.enumerated() {
                viewConstraints
                    .generateSwiftCode()
                    .replaceIdToUniqueName(allViews: views, constraints: [IBLayoutConstraint](constraints.joined()))
                if index != constraints.count - 1 {
                    Line.newLine
                }
            }
        }
    }
    
}


//MARK: Private extensions

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
            if let uniqueName = view.uniqueName { return (uniqueName, view) }
            
            if let count = classTypeCounts[view.classType] {
                classTypeCounts.updateValue(count + 1, forKey: view.classType)
            }
            else {
                /*
                 When classType is .view, the count is set from scratch instead of
                 starting from zero to prevent name conflicts with view, which is a
                 property of UIViewController.
                 */
                if view.classType == .view {
                    classTypeCounts.updateValue(1, forKey: view.classType)
                }
                else {
                    classTypeCounts.updateValue(0, forKey: view.classType)
                }
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
    
    func exceptCell() -> [IBView] {
        self.filter {
            let excepts: [IBCompatibleView] = [.tableViewCell, .collectionViewCell, .collectionViewCellContentView]
            return !excepts.contains($0.classType)
        }
    }
    
}

private extension Array where Element == IBLayoutConstraint {
    func grouped() -> [[IBLayoutConstraint]] {
        var group: [[IBLayoutConstraint]] = []
        var tmp: [IBLayoutConstraint] = []
        var previousID: String?
        let sorted = self.sorted { $0.firstItem < $1.firstItem }
        
        for (index, constraint) in sorted.enumerated() {
            defer {
                previousID = constraint.firstItem
                if index == sorted.count - 1 {
                    group.append(tmp)
                }
            }
            
            guard let previousID = previousID else {
                tmp.append(constraint)
                continue
            }
            
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
