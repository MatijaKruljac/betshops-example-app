//
//  BetshopDetailsViewControllerDelegate.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/30/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import CoreLocation

protocol BetshopDetailsViewControllerDelegate: class {
    
    func didTapCloseButton()
    func didTapRouteButton(betshopLocation: CLLocationCoordinate2D)
}
