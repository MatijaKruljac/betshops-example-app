//
//  BetshopsCoordinator.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class BetshopsCoordinator {
    
    private let useCase: BetshopsUseCase
    private let application: UIApplication
    
    init(viewController: BetshopsViewController, application: UIApplication = UIApplication.shared) {
        let presenter = BetshopsPresenter(viewController: viewController)
        self.useCase = BetshopsUseCase(presenter: presenter)
        self.application = application
    }
    
    // MARK: - Public methods
    
    func viewDidLoad() {
        useCase.getBetshops()
        useCase.requestWhenInUseAuthorization()
        useCase.startUpdatingLocation()
    }
    
    func getBetshops(for boundingBox: BoundingBox) {
        useCase.getBetshops(boundingBox: boundingBox.parameterRepresentation)
    }
    
    func showNavigationPathInAppleMaps(from userLocation: CLLocationCoordinate2D,
                                       to betshopLocation: CLLocationCoordinate2D) {
        guard let appleMapsUrl = URL(string:
            "http://maps.apple.com/?" +
                "saddr=\(userLocation.latitude),\(userLocation.longitude)" +
            "&daddr=\(betshopLocation.latitude),\(betshopLocation.longitude)")
            else { return }
        if application.canOpenURL(appleMapsUrl) {
            _ = application.open(appleMapsUrl, options: [:], completionHandler: nil)
        }
    }
    
    func getBetshop(with coordinate: CLLocationCoordinate2D,
                    from betshops: [BetshopViewModel]?) -> BetshopViewModel? {
        return betshops?.filter {
            return $0.latitude == coordinate.latitude &&
                $0.longitude == coordinate.longitude
            }.first
    }
}
