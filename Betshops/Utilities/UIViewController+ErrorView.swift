//
//  UIViewController+ErrorView.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    
    func showErrorView(with message: String, for duration: TimeInterval = 3) {
        let errorView = createErrorView(with: message)
        view.addSubview(errorView)
        
        addConstraints(for: errorView)
        showAnimated(errorView: errorView)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.hideAnimated(errorView: errorView)
        }
    }
    
    private func createErrorView(with message: String) -> UILabel {
        let errorView = UILabel()
        errorView.backgroundColor = .appRed
        errorView.textColor = .white
        errorView.textAlignment = .center
        errorView.font = UIFont.systemFont(ofSize: 15)
        errorView.alpha = 0
        errorView.text = message
        
        return errorView
    }
    
    private func addConstraints(for errorView: UILabel) {
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        let topOffset = UIApplication.shared.statusBarFrame.height + navigationBarHeight
        errorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topOffset)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    private func showAnimated(errorView: UILabel) {
        animateErrorView(animation: {
            errorView.alpha = 1
        })
    }
    
    private func hideAnimated(errorView: UILabel) {
        animateErrorView(animation: {
            errorView.alpha = 0
        }, completion: {
            errorView.removeFromSuperview()
        })
    }
    
    private func animateErrorView(animation: @escaping () -> Void, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            animation()
        }, completion: { completed in
            guard completed else {
                return
            }
            completion?()
        })
    }
}
