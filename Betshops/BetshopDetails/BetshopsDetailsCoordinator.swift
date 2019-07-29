//
//  BetshopsDetailsCoordinator.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

class BetshopsDetailsCoordinator {
    
    private let useCase: BetshopsDetailsUseCase
    
    init(viewController: BetshopsDetailsViewController) {
        let presenter = BetshopDetailsPresenter(viewController: viewController)
        self.useCase = BetshopsDetailsUseCase(presenter: presenter)
    }
    
    // MARK: - Public methods
    
    func showWorkingHoursDescription(for betshop: BetshopViewModel?) {
        guard let betshop = betshop else {
            return
        }
        useCase.showWorkingHoursDescription(for: betshop)
    }
}
