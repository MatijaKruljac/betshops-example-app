//
//  BetshopsUseCase.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

class BetshopsUseCase {
    
    private let defaultLocation = CLLocation(latitude: 44.435105, longitude: 26.100019)
    
    private let gateway: BetshopsGateway
    private let locationManagerGateway: LocationManagerGateway
    private let presenter: BetshopsPresenter
    private let disposeBag = DisposeBag()
    
    init(gateway: BetshopsGateway = BetshopsGateway(),
         locationManagerGateway: LocationManagerGateway = LocationManagerGateway(),
         presenter: BetshopsPresenter) {
        self.gateway = gateway
        self.locationManagerGateway = locationManagerGateway
        self.presenter = presenter
        setLocationManagerGatewayDelegate()
    }
    
    // MARK: - Public methods
    
    func getBetshops(boundingBox: String = "44.581149,26.304202,44.299059,25.553844") {
        gateway
            .fetchBetshops(boundingBox: boundingBox)
            .subscribeOnBackgroundObserveOnMain()
            .subscribe { [weak self] event in
                switch event {
                case .success(let betshopModels):
                    self?.presenter.show(betshopModels: betshopModels)
                case .error(let error):
                    guard let localError = error as? LocalError else {
                        self?.presenter.show(error: error.localizedDescription)
                        return
                    }
                    self?.presenter.show(error: localError.description)
                }
            }.disposed(by: disposeBag)
    }
    
    func requestWhenInUseAuthorization() {
        locationManagerGateway.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        let persmissionResult = locationManagerGateway.startUpdatingLocation()
        switch persmissionResult {
        case .deniedDeviceBased, .deniedAppBased, .unknown:
            presenter.positionMap(on: defaultLocation)
            return
        case .allowed:
            return
        }
    }
    
    // MARK: - Private methods
    
    private func setLocationManagerGatewayDelegate() {
        locationManagerGateway.delegate = self
    }
}

extension BetshopsUseCase: LocationManagerGatewayDelegate {
    
    func didAutolocate(on location: CLLocation) {
        presenter.positionMap(on: location)
    }
}
