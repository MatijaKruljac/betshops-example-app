//
//  BetshopViewModel.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

struct BetshopViewModel {
    
    var id: Int
    var name: String?
    var city: String?
    var county: String?
    var address: String?
    var contact: String?
    var latitude: Double?
    var longitude: Double?
    var workingHourEnd: String?
    var workingHourStart: String?
}

extension BetshopViewModel {
    
    init(model: BetshopModel) {
        self.id = model.id
        self.name = model.name
        self.city = model.city
        self.county = model.county
        self.address = model.address
        self.contact = model.phone
        self.latitude = model.location?.latitude
        self.longitude = model.location?.longitude
        self.workingHourStart = model.workingHourStart
        self.workingHourEnd = model.workingHourEnd
    }
    
    static func == (lhs: BetshopViewModel, rhs: BetshopViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
