//
//  IBGestureRecognizer+generator.swift
//  
//
//  Created by Ryu on 2022/09/01.
//

import Foundation

extension IBGestureRecognizer: SwiftGeneratable {
    
    func generateSwiftCode() -> [Line] {
        guard let gestureType = gestureType else {
            return []
        }
        
        let uniqueName = uniqueName ?? "view"
        let gestureVariableName = [uniqueName, gestureType.variableName].camelized()
        let functionName = [uniqueName, gestureType.functionName].camelized()
        
        return buildLines {
            Line(variableName: gestureVariableName, lineType: .declare(isMutating: false, type: nil, operand: "\(gestureType.className)(target: self, action: #selector(\(functionName)(_:)))"))
            generateCustomizeCode()
            Line(variableName: uniqueName, lineType: .function("\(uniqueName).addGestureRecognizer(\(gestureVariableName))"))
        }
    }
    
    func generateObjcFunction() -> [Line] {
        guard let gestureType = gestureType else { return [] }
        
        let uniqueName = uniqueName ?? "view"
        let functionName = [uniqueName, gestureType.functionName].camelized()
        
        return generateFunction(name: functionName,
                                arguments: [
                                    .init(argumentName: "_ \(gestureType.variableName)",
                                          argumentType: gestureType.className)
                                ],
                                accessLevel: "@objc private") { }
    }
    
    private func generateCustomizeCode() -> [Line] {
        guard let gestureType = gestureType else { return [] }
        switch gestureType {
        case .tapGestureRecognizer(_), .pinchGestureRecognizer(_), .rotationGestureRecognizer(_):
            return []
        case .swipeGestureRecognizer(_, let direction):
            return buildLines {
                Line(variableName: gestureType.variableName, lineType: .assign(propertyName: "direction", operand: ".\(direction)"))
            }
        case .panGestureRecognizer(_, let minimumNumberOfTouches):
            return buildLines {
                Line(variableName: gestureType.variableName, lineType: .assign(propertyName: "minimumNumberOfTouches", operand: minimumNumberOfTouches))
            }
        case .screenEdgePanGestureRecognizer(_, let minimumNumberOfTouches):
            return buildLines {
                Line(variableName: gestureType.variableName, lineType: .assign(propertyName: "minimumNumberOfTouches", operand: minimumNumberOfTouches))
            }
        case .pongPressGestureRecognizer(_, let allowableMovement, let minimumPressDuration):
            return buildLines {
                Line(variableName: gestureType.variableName, lineType: .assign(propertyName: "allowableMovement", operand: allowableMovement))
                Line(variableName: gestureType.variableName, lineType: .assign(propertyName: "minimumPressDuration", operand: minimumPressDuration))
            }
        }
    }
    
}
