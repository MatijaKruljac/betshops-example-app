//
//  CLLocationCoordinate2D+Equal.swift
//  Betshops
//
//  Created by Matija Kruljac on 4/3/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
