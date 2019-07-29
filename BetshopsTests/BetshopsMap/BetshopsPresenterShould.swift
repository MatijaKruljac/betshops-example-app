//
//  BetshopsPresenterShould.swift
//  BetshopsTests
//
//  Created by Matija Kruljac on 4/1/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Betshops

class BetshopsPresenterShould: QuickSpec {
    
    override func spec() {
        var viewControllerMock: BetshopsViewControllerMock!
        var sut: BetshopsPresenter!
        
        beforeEach {
            viewControllerMock = BetshopsViewControllerMock()
            sut = BetshopsPresenter(viewController: viewControllerMock)
        }
        
        afterEach {
            viewControllerMock = nil
            sut = nil
        }
        
        describe("func show(betshopModels: [BetshopModel])") {
            it("should map models to view models and present them") {
                sut.show(betshopModels: [model1])
                
                expect(viewControllerMock.betshops?.isEmpty) == false
                expect(viewControllerMock.betshops?.first!.id) == model1.id
                expect(viewControllerMock.betshops?.first!.name) == model1.name
                expect(viewControllerMock.betshops?.first!.address) == model1.address
                expect(viewControllerMock.betshops?.first!.county) == model1.county
                expect(viewControllerMock.betshops?.first!.city) == model1.city
                expect(viewControllerMock.betshops?.first!.latitude) == model1.location?.latitude
                expect(viewControllerMock.betshops?.first!.longitude) == model1.location?.longitude
            }
        }
    }
}
