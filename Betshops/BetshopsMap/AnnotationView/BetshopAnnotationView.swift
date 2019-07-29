//
//  BetshopAnnotationView.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import MapKit

class BetshopAnnotationView: MKAnnotationView {
    
    static let identifier = String(describing: BetshopAnnotationView.self)
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        image = UIImage
            .betshop_pin?
            .resizeImage(to: CGSize(width: 32, height: 40))
    }
}
