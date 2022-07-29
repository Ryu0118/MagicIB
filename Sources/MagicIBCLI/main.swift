import Foundation
import MagicIBCore

let url = URL(fileURLWithPath: "/Users/shibuya/Swift-Application/MyPackage/IBLinkTest/IBLinkTest/Base.lproj/Main.storyboard")

try? IBParser().parse(url)
