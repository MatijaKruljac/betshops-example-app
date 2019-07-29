//
//  MKMapView+Coordinates.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
    func contains(coordinates: CLLocationCoordinate2D) -> Bool {
        return annotations.contains { $0.coordinate == coordinates }
    }
}
