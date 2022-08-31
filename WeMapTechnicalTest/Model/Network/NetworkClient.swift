//
//  NetworkClient.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation
import Combine

final class NetworkClient<T: Decodable> {

    // MARK: - Properties

    private var service: PNetowrkService
    var decoder = JSONDecoder()

    // MARK: - Init

    init(service: PNetowrkService = NetworkService()) {
        self.service = service
    }

    // MARK: - Methodes

    func fetchData(from url: URL) -> AnyPublisher<T, Error> {
        service.fetchData(from: url)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse,
                      WMNetworkError(response: response) != nil {
                    throw WMNetworkError(response: response)!
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
