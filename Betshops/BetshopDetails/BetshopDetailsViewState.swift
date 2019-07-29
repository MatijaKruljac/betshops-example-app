//
//  BetshopDetailsViewState.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/30/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

enum BetshopDetailsViewState {
    
    case notVisible
    case visible
    
    var height: CGFloat {
        switch self {
        case .notVisible:
            return 0
        case .visible:
            return 240
        }
    }
}
