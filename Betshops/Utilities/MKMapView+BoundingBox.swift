//
//  MKMapView+BoundingBox.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/30/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

extension MKMapView {
    
    var boundingBox: BoundingBox {
        let southWest = MKMapPoint(x: visibleMapRect.origin.x, y: visibleMapRect.maxY).coordinate
        let northEast = MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.origin.y).coordinate
        
        return BoundingBox(southWest: southWest, northEast: northEast)
    }
}
