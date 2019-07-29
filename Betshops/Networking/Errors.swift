//
//  Errors.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

enum LocalError: Error {
    
    case badRequestStructure
    case parsingError
    
    var description: String {
        switch self {
        case .badRequestStructure:
            return "Bad request structure."
        case .parsingError:
            return "Unable to parse data."
        }
    }
}

enum APIError: Error {
    
    case notHTTPResponse
    case invalidResponse
    case invalidStatusCode(code: Int)
    case unknownError
    
    var description: String {
        switch self {
        case .notHTTPResponse:
            return "Not a HTTP response."
        case .invalidResponse:
            return "Invalid response."
        case .invalidStatusCode(let code):
            return "Invalid status code \(code)."
        case .unknownError:
            return "Unknown error occured."
        }
    }
}
