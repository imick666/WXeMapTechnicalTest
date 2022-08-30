//
//  WeMapService.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation
import Combine


final class WeMapService {
    
    private var client: NetworkClient<WeMapResponse>
    
    init(client: NetworkClient<WeMapResponse> = NetworkClient()) {
        self.client = client
    }
    
    func fetchPois(for search: String) -> AnyPublisher<[Poi], Error> {
        let baseUrl = URL(string: "https://api.getwemap.com/v3.0/pinpoints/search?list=75426")!
        
        return client.fetchData(from: baseUrl)
            .map { $0.results }
            .eraseToAnyPublisher()
        
        
    }
    
}
