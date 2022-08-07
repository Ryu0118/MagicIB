//
//  IBWebView.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

class IBWebView: IBView {
    private let webViewProperties: [IBPropertyMapper] = [
        .init(propertyName: <#T##String#>, type: <#T##IBInspectableType#>)
    ]
}
/*
 <wkWebView contentMode="scaleToFill" allowsBackForwardNavigationGestures="YES" allowsLinkPreview="NO" customUserAgent="CustomAgent" translatesAutoresizingMaskIntoConstraints="NO" id="TF5-zo-d9k">
     <rect key="frame" x="0.0" y="44" width="414" height="818"/>
     <color key="backgroundColor" red="0.36078431370000003" green="0.38823529410000002" blue="0.4039215686" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
     <wkWebViewConfiguration key="configuration" allowsAirPlayForMediaPlayback="NO" allowsInlineMediaPlayback="YES" allowsPictureInPictureMediaPlayback="NO" applicationNameForUserAgent="IBLinkTest" selectionGranularity="character" suppressesIncrementalRendering="YES">
         <dataDetectorTypes key="dataDetectorTypes" none="YES"/>
         <audiovisualMediaTypes key="mediaTypesRequiringUserActionForPlayback" audio="YES" video="YES"/>
         <wkPreferences key="preferences" javaScriptCanOpenWindowsAutomatically="YES" javaScriptEnabled="NO" minimumFontSize="2"/>
     </wkWebViewConfiguration>
 </wkWebView>
 
 <wkWebView contentMode="scaleAspectFill" customUserAgent="CustomAgent" translatesAutoresizingMaskIntoConstraints="NO" id="TF5-zo-d9k">
     <rect key="frame" x="0.0" y="44" width="414" height="818"/>
     <color key="backgroundColor" red="0.36078431370000003" green="0.38823529410000002" blue="0.4039215686" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
     <wkWebViewConfiguration key="configuration" applicationNameForUserAgent="IBLinkTest" selectionGranularity="character">
         <dataDetectorTypes key="dataDetectorTypes" phoneNumber="YES" link="YES" address="YES" calendarEvent="YES" trackingNumber="YES" flightNumber="YES" lookupSuggestion="YES"/>
         <audiovisualMediaTypes key="mediaTypesRequiringUserActionForPlayback" none="YES"/>
         <wkPreferences key="preferences" minimumFontSize="3"/>
     </wkWebViewConfiguration>
 </wkWebView>
 */
