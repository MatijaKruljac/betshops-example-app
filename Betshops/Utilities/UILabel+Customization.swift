//
//  UILabel+Customization.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/30/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setAsMultipleLineLabel(numberOfLines: Int = 3) {
        lineBreakMode = .byWordWrapping
        self.numberOfLines = numberOfLines
    }
}
