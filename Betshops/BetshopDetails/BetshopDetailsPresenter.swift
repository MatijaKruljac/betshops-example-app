//
//  BetshopDetailsPresenter.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

class BetshopDetailsPresenter {
    
    private unowned let viewController: BetshopsDetailsViewController
    
    init(viewController: BetshopsDetailsViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Public methods
    
    func setWorkingHours(description: String) {
        viewController.setWorkingHours(description: description)
    }
}
