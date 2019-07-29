//
//  ViewController.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class BetshopsViewController: UIViewController {
    
    // MARK: - Public properties
    
    var betshops: [BetshopViewModel]? {
        didSet {
            betshops?.forEach { [weak self] in
                guard let latitude = $0.latitude,
                    let longitude = $0.longitude else {
                        return
                }
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                guard !mapView.contains(coordinates: coordinates) else {
                    return
                }
                let placemark = MKPlacemark(coordinate: coordinates)
                self?.mapView.addAnnotation(placemark)
            }
        }
    }
    
    // MARK: - Private properties
    
    private let mapView = MKMapView()
    private let betshopDetailsViewController = BetshopsDetailsViewController()
    
    private var coordinator: BetshopsCoordinator?
    private var userLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoordinator()
        setupUI()
    }
    
    // MARK: - Public methods
    
    func positionMap(on location: CLLocation) {
        userLocation = location
        mapView.setCenter(location.coordinate, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupCoordinator() {
        coordinator = BetshopsCoordinator(viewController: self)
        coordinator?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Bet shops"
        addSubviews()
        setupMapView()
        setupBetShopDetailsViewController()
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(betshopDetailsViewController.view)
    }
    
    private func setupMapView() {
        mapView.register(BetshopAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: BetshopAnnotationView.identifier)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBetShopDetailsViewController() {
        betshopDetailsViewController.delegate = self
        betshopDetailsViewController.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension BetshopsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        return mapView.dequeueReusableAnnotationView(withIdentifier: BetshopAnnotationView.identifier)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.image = UIImage
            .betshop_selected_pin?
            .resizeImage(to: CGSize(width: 40, height: 48))
        betshopDetailsViewController.betshop = getBetshop(for: view)
    }
    
    private func getBetshop(for annotationView: MKAnnotationView) -> BetshopViewModel? {
        guard let annotation = annotationView.annotation else {
            return nil
        }
        return coordinator?.getBetshop(with: annotation.coordinate, from: betshops)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage
            .betshop_pin?
            .resizeImage(to: CGSize(width: 32, height: 40))
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let boundingBox = mapView.boundingBox
        coordinator?.getBetshops(for: boundingBox)
    }
}

extension BetshopsViewController: BetshopDetailsViewControllerDelegate {
    
    func didTapCloseButton() {
        mapView.selectedAnnotations.forEach { [weak self] in
            self?.mapView.deselectAnnotation($0, animated: true)
        }
    }
    
    func didTapRouteButton(betshopLocation: CLLocationCoordinate2D) {
        guard let userLocation = userLocation?.coordinate else {
            return
        }
        coordinator?.showNavigationPathInAppleMaps(from: userLocation,
                                                   to: betshopLocation)
    }
}
