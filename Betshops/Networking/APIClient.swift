//
//  APIClient.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import RxSwift

class APIClient {
    
    static let shared = APIClient()
    
    private let session = URLSession.shared
    
    private init() {}
    
    func send(request: URLRequest) -> Single<Data> {
        return Single<Data>.create { [weak self] single in
            guard let `self` = self else {
                return Disposables.create {}
            }
            
            let task = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    single(.error(APIError.notHTTPResponse))
                    return
                }
                
                let code = response.statusCode
                
                guard (200..<300).contains(code) else {
                    single(.error(APIError.invalidStatusCode(code: code)))
                    return
                }
                
                guard let data = data else {
                    single(.error(APIError.invalidResponse))
                    return
                }
                
                single(.success(data))
            })
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
