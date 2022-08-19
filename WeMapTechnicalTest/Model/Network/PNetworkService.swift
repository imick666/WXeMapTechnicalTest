//
//  PNetworkService.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation
import Combine

protocol PNetowrkService {
    func fetchData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
    
}
