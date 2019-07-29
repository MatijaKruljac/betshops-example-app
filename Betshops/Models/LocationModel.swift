//
//  LocationModel.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

struct LocationModel: Codable {
    
    var latitude: Double?
    var longitude: Double?
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "Lat"
        case longitude = "Lng"
    }
}
