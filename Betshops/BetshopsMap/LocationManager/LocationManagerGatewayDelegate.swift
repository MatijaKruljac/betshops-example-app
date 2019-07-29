//
//  LocationManagerGatewayDelegate.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerGatewayDelegate: class {
    
    func didAutolocate(on location: CLLocation)
}
