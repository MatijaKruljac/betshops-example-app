//
//  BetshopsPresenter.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import CoreLocation

class BetshopsPresenter {
    
    private unowned let viewController: BetshopsViewController
    
    init(viewController: BetshopsViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Public methods
    
    func show(betshopModels: [BetshopModel]) {
        let betshopViewModels = betshopModels.map { BetshopViewModel(model: $0) }
        viewController.betshops = betshopViewModels
    }
    
    func show(error: String) {
        viewController.showErrorView(with: error)
    }
    
    func positionMap(on location: CLLocation) {
        viewController.positionMap(on: location)
    }
}
