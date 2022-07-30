import Foundation
import MagicIBCore

let url = URL(fileURLWithPath: "/Users/shibuya/Swift-Application/MyPackage/IBLinkTest/IBLinkTest/Constraint.storyboard")

try? IBParser().parse(url)
