//
//  LocationManagerGatewayMock.swift
//  BetshopsTests
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
@testable import Betshops

class LocationManagerGatewayMock: LocationManagerGateway {
    
    var didCallRequestWhenInUseAuthorization = false
    var didCallStartUpdatingLocation = false
    
    override func requestWhenInUseAuthorization() {
        didCallRequestWhenInUseAuthorization = true
    }
    
    override func startUpdatingLocation() -> LocationPermission {
        didCallStartUpdatingLocation = true
        
        return .allowed
    }
}
