//
//  BetshopsGatewayMock.swift
//  BetshopsTests
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import RxSwift
@testable import Betshops

class BetshopsGatewayMock: BetshopsGateway {
    
    var didErrorOccurred = false
    var boundingBox: String?
    
    override func fetchBetshops(boundingBox: String) -> Single<[BetshopModel]> {
        self.boundingBox = boundingBox
        if didErrorOccurred {
            return Single.error(ErrorMock())
        }
        
        return Single.just([model1])
    }
}
