//
//  Date+String.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/30/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

extension String {
    
    var asDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
}
