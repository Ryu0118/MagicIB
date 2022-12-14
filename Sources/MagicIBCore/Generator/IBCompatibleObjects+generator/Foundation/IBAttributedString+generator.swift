//
//  IBAttributedString+generator.swift
//  
//
//  Created by Ryu on 2022/08/17.
//

import Foundation

extension IBAttributedString: SwiftGeneratable {
    
    enum Mode {
        case modern
        case legacy
    }
    
    func generateSwiftCode() -> [Line] { generateSwiftCode(mode: .modern) }
    
    func generateSwiftCode(mode: Mode) -> [Line] {
        guard let variableName = uniqueName else { return [] }
        switch mode {
        case .modern:
            return buildLines {
                Line(variableName: variableName, lineType: .declare(isMutating: true, operand: "AttributedString(\"\(text)\")"))
                fragments.flatMap { $0.generateSwiftCode(mode: .modern) }
            }
        case .legacy:
            return buildLines {
                fragments
                    .enumerated()
                    .flatMap { $1.generateSwiftCode(mode: .legacy(fragmentCount: $0)) }
                Line(variableName: "attributedString", lineType: .declare(isMutating: false, operand: "NSMutableAttributedString()"))
                
                for i in 1...fragments.count {
                    Line(variableName: "attributedString", lineType: .function("attributedString.append(string\(i))"))
                }
            }
        }
    }
    
}

extension IBAttributedString.Fragment: SwiftGeneratable {
    enum Mode {
        case modern
        case legacy(fragmentCount: Int)
    }
    
    func generateSwiftCode() -> [Line] { generateSwiftCode(mode: .modern) }
    
    func generateSwiftCode(mode: Mode) -> [Line] {
        guard let content = self.content as? String,
              let variableName = self.uniqueName
        else { return [] }
        switch mode {
        case .modern:
            /*
             var attributedString = AttributedString(str)
             
             if let range = attributedString.range(of: "string") {
             attributedString[range].foregroundColor = .red
             attributedString[range].font = .systemFont(ofSize: 12)
             }
             */
            return generateModernAttributes(variableName: variableName, content: content)
        case .legacy(let count):
            return generateLegacyAttributes(count: count, content: content)
        }
    }
    
    private func generateModernAttributes(variableName: String, content: String) -> [Line] {
        buildLines {
            Line(relatedVariableName: variableName, custom: "if let range = \(variableName).range(of: \"\(content)\") {")
            generateCustomizablePropertyLines(variableName: "\(variableName)[range]")
            generateNonCustomizablePropertyLines(variableName: "\(variableName)[range]")
            Line.end.changeVariableName(variableName)
        }
    }
    
    private func generateLegacyAttributes(count: Int, content: String) -> [Line] {
        let attributeName = "stringAttributes\(count + 1)"
        let stringName = "string\(count + 1)"
        
        //NSMutableParagraphStyle
        var paragraphStyleLines = [Line]()
        if let paragraphStyle = findProperty(ib: "NSParagraphStyle")?.value as? IBParagraphStyle {
            paragraphStyleLines = paragraphStyle.generateSwiftCode()
            paragraphStyleLines.forEach {
                $0.changeVariableName($0.variableName + "\(count + 1)")
            }
        }
        
        return buildLines {
            //let stringAttributes1: [NSAttributedStringKey : Any] = [
            paragraphStyleLines
            Line(variableName: attributeName, lineType: .declare(isMutating: false, type: "[NSAttributedString.Key : Any]", operand: "["))
            
            /*
             let stringAttributes1: [NSAttributedStringKey : Any] = [
             .foregroundColor : UIColor.blue,
             .font : UIFont.systemFont(ofSize: 24.0),
             .paragraphStyle: NSParagraphStyle.default
             ]
             */
            generateAttributes(attributeName: attributeName, paragraphStyleLines: paragraphStyleLines)
            
            Line(relatedVariableName: attributeName, custom: "]")
            //let string1 = NSAttributedString(string: "0123", attributes: stringAttributes1)
            Line(variableName: stringName, lineType: .declare(isMutating: false, operand: "NSAttributedString(string: \"\(content)\", attributes: \(attributeName))"))
        }
    }
    
    
    private func generateAttributes(attributeName: String, paragraphStyleLines: [Line]) -> [Line] {
        buildLines {
            activatedProperties.compactMap { property in
                if let nonCustomizable = property.value as? NonCustomizable {
                    var type: String?
                    if let _ = property.value as? IBColor {
                        type = "UIColor"
                    }
                    else if let _ = property.value as? IBFont {
                        type = "UIFont"
                    }
                    
                    guard let type = type,
                          let firstLine = nonCustomizable.generateSwiftCode().first
                    else {
                        return nil
                        /*
                        fatalError("failed to get right operand. propertyName: \(property.propertyName)")
                         */
                    }
                    let rightOperand = firstLine.explicitType(type).originalValue
                    return Line(relatedVariableName: attributeName, custom: ".\(property.propertyName): \(rightOperand),")
                }
                else if let _ = property.value as? IBParagraphStyle,
                        let variableName = paragraphStyleLines.last?.variableName {
                    return Line(relatedVariableName: attributeName, custom: ".\(property.propertyName): \(variableName),")
                }
                else {
                    return nil
                }
            }
        }
    }
}
