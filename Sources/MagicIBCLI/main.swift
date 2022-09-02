import Foundation
import MagicIBCore
///Users/shibuya/Swift-Application/MyPackage/IBLinkTest/Test1.storyboard
////Users/shibuya/Swift-Application/MyPackage/IBLinkTest/IBLinkTest/Constraint.storyboard
////Users/shibuya/Swift-Application/MyPackage/IBLinkTest/IBLinkTest/Base.lproj/Main.storyboard
let url = URL(fileURLWithPath: "/Users/shibuya/Swift-Application/MyPackage/IBLinkTest/Gesture.storyboard")

try? IBParser().parse(url)
