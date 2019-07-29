//
//  UINavitgationBar+Customization.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addNavigationBarCustomization(color: UIColor = .appGreen) {
        navigationBar.barTintColor = color
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    }
}
