//
//  BetshopsUseCaseShould.swift
//  BetshopsTests
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
@testable import Betshops

class BetshopsUseCaseShould: QuickSpec {
    
    override func spec() {
        
        var gatewayMock: BetshopsGatewayMock!
        var locationManagerGatewayMock: LocationManagerGatewayMock!
        var presenterMock: BetshopsPresenterMock!
        var sut: BetshopsUseCase!
        
        beforeEach {
            gatewayMock = BetshopsGatewayMock()
            locationManagerGatewayMock = LocationManagerGatewayMock()
            presenterMock = BetshopsPresenterMock(viewController: BetshopsViewControllerMock())
            sut = BetshopsUseCase(gateway: gatewayMock,
                                  locationManagerGateway: locationManagerGatewayMock,
                                  presenter: presenterMock)
        }
        
        afterEach {
            gatewayMock = nil
            locationManagerGatewayMock = nil
            presenterMock = nil
            sut = nil
        }
        
        describe("func getBetshops(boundingBox: String)") {
            context("and error did not occur") {
                it("should fetch betshops models and map it to betshops view models") {
                    let boundingBox = "11,22,33,44"
                    
                    sut.getBetshops(boundingBox: boundingBox)
                    
                    expect(gatewayMock.boundingBox).toEventually(match(boundingBox))
                    expect(presenterMock.betshopModels?.isEmpty).toEventually(beFalse())
                    expect(presenterMock.betshopModels?.first!.id).toEventually(be(model1.id))
                    expect(presenterMock.betshopModels?.first!.name).toEventually(match(model1.name))
                    expect(presenterMock.betshopModels?.first!.address).toEventually(match(model1.address))
                    expect(presenterMock.betshopModels?.first!.county).toEventually(match(model1.county))
                    expect(presenterMock.betshopModels?.first!.city).toEventually(match(model1.city))
                    expect(presenterMock.betshopModels?.first!.location!.latitude).toEventually(be(model1.location?.latitude))
                    expect(presenterMock.betshopModels?.first!.location!.longitude).toEventually(be(model1.location?.longitude))
                }
            }
            
            context("and error did occur") {
                it("should tell presenter to show error") {
                    gatewayMock.didErrorOccurred = true
                    
                    let boundingBox = "11,22,33,44"
                    let errorMessage = "Error occurred"
                    
                    sut.getBetshops(boundingBox: boundingBox)
                    
                    expect(gatewayMock.boundingBox).toEventually(match(boundingBox))
                    expect(presenterMock.error).toEventually(match(errorMessage))
                    expect(presenterMock.betshopModels).toEventually(beNil())
                }
            }
        }
        
        describe("func requestWhenInUseAuthorization()") {
            it("should call request for authorization to use location when app is in use") {
                sut.requestWhenInUseAuthorization()
                
                expect(locationManagerGatewayMock.didCallRequestWhenInUseAuthorization) == true
            }
        }
        
        describe("func startUpdatingLocation()") {
            it("should tell LocationManagerGateway to start updating user location") {
                sut.startUpdatingLocation()
                
                expect(locationManagerGatewayMock.didCallStartUpdatingLocation) == true
            }
        }
    }
}
