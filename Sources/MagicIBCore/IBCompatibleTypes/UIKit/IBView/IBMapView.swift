//
//  IBMapView.swift
//  
//
//  Created by Ryu on 2022/08/07.
//

import Foundation

class IBMapView: IBView {
    private let mapViewProperties: [IBPropertyMapper] = [
        .init(propertyName: "mapType", type: .enum),
        .init(propertyName: "showsUserLocation", type: .bool),
        .init(propertyName: "showsScale", type: .bool),
        .init(propertyName: "showsTraffic", type: .bool),
        .init(ib: "zoomEnabled", propertyName: "isZoomEnabled", type: .bool),
        .init(ib: "scrollEnabled", propertyName: "isScrollEnabled", type: .bool),
        .init(ib: "rotateEnabled", propertyName: "isRotateEnabled", type: .bool),
        .init(ib: "pitchEnabled", propertyName: "isPitchEnabled", type: .bool),
        .init(propertyName: "showsBuildings", type: .bool),
        .init(propertyName: "showsCompass", type: .bool),
        .init(propertyName: "showsPointsOfInterest", type: .bool),
    ]
    
    override var properties: [IBPropertyMapper] {
        super.properties + mapViewProperties
    }
}
