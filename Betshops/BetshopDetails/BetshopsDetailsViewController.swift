//
//  BetshopsDetailsViewController.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation

class BetshopsDetailsViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: BetshopDetailsViewControllerDelegate?
    
    var betshop: BetshopViewModel? {
        didSet {
            if didTapFirstTimeAfterLaunch(betshop: oldValue) {
                update(state: .visible) { [weak self] in
                    self?.updateUI()
                }
                return
            }
            if didTapOnSameMarker(old: oldValue, current: betshop) {
                update(state: .visible)
                return
            }
            if didTapOnNewMarker(old: oldValue) {
                update(state: .notVisible) { [weak self] in
                    self?.update(state: .visible)
                    self?.updateUI()
                }
                return
            }
        }
    }
    
    // MARK: - Private properties
    
    private let closeButton = UIButton()
    
    private let betshopImageView = UIImageView()
    private let betshopAddressLabel = UILabel()
    private lazy var addressStackView = UIStackView(arrangedSubviews: [self.betshopImageView,
                                                                       self.betshopAddressLabel])
    private let betshopContactImageView = UIImageView()
    private let betshopContactLabel = UILabel()
    private lazy var contactStackView = UIStackView(arrangedSubviews: [self.betshopContactImageView,
                                                                       self.betshopContactLabel])
    private let openingHoursLabel = UILabel()
    private let hairLineView = UIView()
    private let routeButton = UIButton()
    private lazy var optionsStackView = UIStackView(arrangedSubviews: [self.openingHoursLabel,
                                                                       self.hairLineView,
                                                                       self.routeButton])
    private var coordinator: BetshopsDetailsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoordinator()
        setupUI()
    }
    
    // MARK: - Public methods
    
    func setWorkingHours(description: String) {
        openingHoursLabel.text = description
    }
    
    // MARK: - Private methods
    
    private func setupCoordinator() {
        coordinator = BetshopsDetailsCoordinator(viewController: self)
    }
    
    private func setupUI() {
        view.addRoundedCorners(cornerRadius: 16)
        view.addShadow()
        view.backgroundColor = .white
        addSubviews()
        setupCloseButton()
        setupBetshopImageView()
        setupBetshopAddressLabel()
        setupAddressStackView()
        setupBetshopContactImageView()
        setupBetshopContactLabel()
        setupContactStackView()
        setupOpeningHoursLabel()
        setupHairLineView()
        setupRouteButton()
        setupOptionsStackView()
    }
    
    private func addSubviews() {
        view.addSubview(closeButton)
        view.addSubview(addressStackView)
        view.addSubview(contactStackView)
        view.addSubview(optionsStackView)
    }
    
    private func setupCloseButton() {
        closeButton.setImage(UIImage.betshop_close_button, for: .normal)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapCloseButton() {
        delegate?.didTapCloseButton()
        update(state: .notVisible)
    }
    
    private func setupBetshopImageView() {
        betshopImageView.image = UIImage.betshop_location
        betshopImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 24))
        }
    }
    
    private func setupBetshopAddressLabel() {
        betshopAddressLabel.setAsMultipleLineLabel(numberOfLines: 4)
        betshopAddressLabel.font = UIFont.systemFont(ofSize: 17)
    }
    
    private func setupAddressStackView() {
        addressStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(closeButton.snp.leading).offset(-16)
        }
        addressStackView.alignment = .top
        addressStackView.axis = .horizontal
        addressStackView.distribution = .fill
        addressStackView.spacing = 16
    }
    
    private func setupBetshopContactImageView() {
        betshopContactImageView.image = UIImage.betshop_contact
        betshopContactImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 24))
        }
    }
    
    private func setupBetshopContactLabel() {
        betshopContactLabel.setAsMultipleLineLabel()
        betshopContactLabel.font = UIFont.systemFont(ofSize: 17)
    }
    
    private func setupContactStackView() {
        contactStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(addressStackView.snp.bottom).offset(24)
            make.trailing.equalTo(closeButton.snp.leading)
        }
        contactStackView.alignment = .center
        contactStackView.axis = .horizontal
        contactStackView.distribution = .fill
        contactStackView.spacing = 16
    }
    
    private func setupOpeningHoursLabel() {
        openingHoursLabel.font = UIFont.boldSystemFont(ofSize: 15)
        openingHoursLabel.textColor = .appGreen
    }
    
    private func setupHairLineView() {
        hairLineView.backgroundColor = .appGray
        hairLineView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 1, height: 32))
        }
    }
    
    private func setupRouteButton() {
        routeButton.setTitle("Route", for: .normal)
        routeButton.setTitleColor(.appDarkBlue, for: .normal)
        routeButton.addTarget(self, action: #selector(didTapRouteButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapRouteButton() {
        guard let latitude = betshop?.latitude,
            let longitude = betshop?.longitude else {
                return
        }
        let coordinates = CLLocationCoordinate2D(latitude: latitude,
                                                 longitude: longitude)
        delegate?.didTapRouteButton(betshopLocation: coordinates)
    }
    
    private func setupOptionsStackView() {
        optionsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(48)
            make.top.equalTo(contactStackView.snp.bottom).offset(24)
            make.trailing.equalTo(closeButton.snp.leading)
        }
        optionsStackView.alignment = .center
        optionsStackView.axis = .horizontal
        optionsStackView.distribution = .equalSpacing
        optionsStackView.spacing = 8
    }
    
    private func update(state: BetshopDetailsViewState, completionBlock: (() -> Void)? = nil) {
        set(new: state.height)
        updateConstraintsAnimated(completionBlock: completionBlock)
    }
    
    private func set(new height: CGFloat) {
        view.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
    }
    
    private func updateConstraintsAnimated(completionBlock: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.view.superview?.layoutIfNeeded()
            }, completion: { completed in
                guard completed else {
                    return
                }
                completionBlock?()
        })
    }
    
    private func didTapFirstTimeAfterLaunch(betshop: BetshopViewModel?) -> Bool {
        return betshop == nil
    }
    
    private func didTapOnSameMarker(old: BetshopViewModel?, current: BetshopViewModel?) -> Bool {
        guard let old = old, let current = current else {
            return false
        }
        
        return old == current
    }
    
    private func didTapOnNewMarker(old: BetshopViewModel?) -> Bool {
        return old != nil
    }
    
    private func updateUI() {
        setBetshopAddressLabelText()
        setBetshopContactLabelText()
        setOpeningHoursLabelText()
    }
    
    private func setBetshopAddressLabelText() {
        if betshop?.name == nil &&
            betshop?.address == nil &&
            betshop?.city == nil &&
            betshop?.county == nil {
            betshopAddressLabel.text = "Uknown"
        } else {
            let fullAddress =
            """
            \(betshop?.name ?? ""),
            \(betshop?.address ?? ""),
            \(betshop?.city ?? "") - \(betshop?.county ?? "")
            """
            betshopAddressLabel.text = fullAddress
        }
    }
    
    private func setBetshopContactLabelText() {
        if betshop?.contact == nil {
            betshopContactLabel.text = "Unknown"
        } else {
            betshopContactLabel.text = "\(betshop?.contact ?? "")"
        }
    }
    
    private func setOpeningHoursLabelText() {
        if betshop?.workingHourStart == nil && betshop?.workingHourEnd == nil {
            openingHoursLabel.text = "Unknown"
        } else {
            coordinator?.showWorkingHoursDescription(for: betshop)
        }
    }
}
