//
//  BetshopsGateway.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import RxSwift

class BetshopsGateway {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func fetchBetshops(boundingBox: String) -> Single<[BetshopModel]> {
        guard let request = APIRequest
            .betshopsList(boundingBox: boundingBox)
            .generated else {
                return Single.error(LocalError.badRequestStructure)
        }
        let single: Single<Data> = apiClient.send(request: request)
        return single.map { data -> [BetshopModel] in
            do {
                return try JSONDecoder().decode([BetshopModel].self, from: data)
            } catch {
                throw LocalError.parsingError
            }
        }
    }
}
