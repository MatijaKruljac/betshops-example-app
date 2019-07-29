//
//  UIView+LayerCustomization.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/30/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addRoundedCorners(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.7,
                   shadowOffset: CGSize = CGSize(width: 2, height: 2),
                   shadowRadius: CGFloat = 4) {
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}
