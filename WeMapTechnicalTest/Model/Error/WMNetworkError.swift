//
//  WMError.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation

enum WMNetworkError: Error, Equatable {
    case notAuthentified
    case accessDenied
    case ressourceNotFound
    case serverError
    case noResponse
    case uknowned
    case other(error: URLError)
    
    init?(response: HTTPURLResponse) {
        switch response.statusCode {
        case 200 ..< 300 : return nil
        case 401: self = .notAuthentified
        case 403: self = .accessDenied
        case 404: self = .ressourceNotFound
        case 500, 502, 503: self = .serverError
        case 504: self = .noResponse
        default: self = .uknowned
        }
    }
    
    init(error: URLError) {
        switch error.code {
        case .fileDoesNotExist: self = .ressourceNotFound
        default: self = .other(error: error)
        }
    }
}
