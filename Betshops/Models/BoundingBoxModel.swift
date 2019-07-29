//
//  BoundingBoxModel.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/30/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import CoreLocation

struct BoundingBox {
    
    let southWest: CLLocationCoordinate2D
    let northEast: CLLocationCoordinate2D
    
    var parameterRepresentation: String {
        return "\(southWest.latitude),\(southWest.longitude),\(northEast.latitude),\(northEast.longitude)"
    }
}
