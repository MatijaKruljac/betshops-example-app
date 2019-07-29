//
//  BetshopsPresenterMock.swift
//  BetshopsTests
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
@testable import Betshops

class BetshopsPresenterMock: BetshopsPresenter {
    
    var betshopModels: [BetshopModel]?
    var error: String?
    
    override func show(betshopModels: [BetshopModel]) {
        self.betshopModels = betshopModels
    }
    
    override func show(error: String) {
        self.error = "Error occurred"
    }
}
