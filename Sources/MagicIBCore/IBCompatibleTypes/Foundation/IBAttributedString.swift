//
//  IBAttributedString.swift
//  
//
//  Created by Ryu on 2022/08/01.
//

import Foundation

struct IBAttributedString {
    let text: String
    
    var fragments = [Fragment]()
    
    init(_ text: String) {
        self.text = text
    }
    
    func addFragment(_ content: String) {
        let fragment = Fragment(content)
        fragments.append(fragment)
    }
    
    func addColorAttributes(_ attributes: [String: String]) {
        fragments.last?.addColor(attributes: attributes)
    }
    
    func addFontAttributes(_ attributes: [String: String]) {
        fragments.last?.addFont(attributes: attributes)
    }
}

extension IBAttributedString {
    
    struct Fragment {
        let content: String
        var backgroundColor: IBColor?
        var foregroundColor: IBColor?
        var font: IBFont?
        
        init(_ content: String) {
            self.content = content
        }
        
        mutating func addColor(attributes: [String: String]) {
            if attributes["key"] == "NSBackgroundColor" {
                self.backgroundColor = IBColor(attributes: attributes)
            }
            else if attributes["key"] == "NSColor" {
                self.foregroundColor = IBColor(attributes: attributes)
            }
        }
        
        mutating func addFont(attributes: [String: String]) {
            font = IBFont(attributes: attributes)
        }
    }
    
}
/*
 <attributedString key="attributedTitle">
     <fragment content="Button">
         <attributes>
             <color key="NSBackgroundColor" red="0.38689356201840963" green="1" blue="0.9702827901134724" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
             <color key="NSColor" name="textColor" catalog="System" colorSpace="catalog"/>
             <font key="NSFont" size="17" name="Helvetica"/>
             <paragraphStyle key="NSParagraphStyle" alignment="center" lineBreakMode="wordWrapping" baseWritingDirection="rightToLeft" lineSpacing="10" paragraphSpacing="3" paragraphSpacingBefore="2" firstLineHeadIndent="3" headIndent="4" minimumLineHeight="25" maximumLineHeight="22" lineHeightMultiple="1" defaultTabInterval="2" hyphenationFactor="0.60000002384185791" tighteningFactorForTruncation="0.40000000596046448" headerLevel="6"/>
         </attributes>
     </fragment>
 </attributedString>
 */
/*
 <attributedString key="attributedTitle">
     <fragment content="B">
         <attributes>
             <color key="NSBackgroundColor" red="1" green="0.18427354967080323" blue="0.0" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
             <color key="NSColor" name="textColor" catalog="System" colorSpace="catalog"/>
             <font key="NSFont" size="12" name="Helvetica"/>
         </attributes>
     </fragment>
     <fragment content="ut">
         <attributes>
             <color key="NSBackgroundColor" red="0.25280958622949923" green="1" blue="0.35790929537639904" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
             <color key="NSColor" name="textColor" catalog="System" colorSpace="catalog"/>
             <font key="NSFont" size="12" name="Helvetica"/>
         </attributes>
     </fragment>
     <fragment content="t">
         <attributes>
             <color key="NSColor" name="textColor" catalog="System" colorSpace="catalog"/>
             <font key="NSFont" size="12" name="Helvetica"/>
         </attributes>
     </fragment>
     <fragment content="o">
         <attributes>
             <color key="NSColor" red="1" green="0.46247963467967257" blue="0.5248354681815578" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
             <font key="NSFont" size="12" name="Helvetica"/>
         </attributes>
     </fragment>
     <fragment content="n">
         <attributes>
             <color key="NSBackgroundColor" red="1" green="0.54422883140039757" blue="0.58987820728073825" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
             <color key="NSColor" name="textColor" catalog="System" colorSpace="catalog"/>
             <font key="NSFont" size="12" name="Helvetica"/>
         </attributes>
     </fragment>
 </attributedString>
 */
