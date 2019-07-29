//
//  LocationManagerUseCase.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationPermission {
    
    case deniedDeviceBased
    case deniedAppBased
    case allowed
    case unknown
}

class LocationManagerGateway: NSObject {
    
    weak var delegate: LocationManagerGatewayDelegate?
    
    fileprivate let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        setupLocationManager()
    }
    
    // MARK: - Public methods
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() -> LocationPermission {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                return .deniedAppBased
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                return .allowed
            @unknown default:
                return .unknown
            }
        }
        
        return .deniedDeviceBased
    }
    
    // MARK: - Private methods
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationManagerGateway: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let location = locations.last else {
            return
        }
        delegate?.didAutolocate(on: location)
    }
}
