//
//  NetworkService.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation
import Combine

final class NetworkService: PNetowrkService {
    func fetchData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
