//
//  ModelMocks.swift
//  BetshopsTests
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
@testable import Betshops

let locationModel1 = LocationModel(latitude: 10, longitude: 20)
let model1 = BetshopModel(id: 10, name: "Test", location: locationModel1,
                          address: "TestAddress", cityId: 123, city: "TestCity",
                          county: "TestCounty", workingHourStart: "10:00", workingHourEnd: "18:00",
                          phone: "0991234567")
