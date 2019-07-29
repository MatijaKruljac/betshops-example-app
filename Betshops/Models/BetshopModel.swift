//
//  Betshop.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

struct BetshopModel: Codable {
    
    var id: Int
    var name: String?
    var location: LocationModel?
    var address: String?
    var cityId: Int?
    var city: String?
    var county: String?
    var workingHourStart: String?
    var workingHourEnd: String?
    var phone: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id", name = "Name",
        location = "Location", address = "Address",
        cityId = "CityId", city = "City",
        county = "County", workingHourStart = "WorkingHourStart",
        workingHourEnd = "WorkingHourEnd", phone = "Phone"
    }
}
