//
//  PreviewNetworkService.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 31/08/2022.
//

import Foundation
import Combine

//  swiftlint:disable force_try
final class PreviewNetworkService: PNetowrkService {
    func fetchData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        let bundle = Bundle(for: PreviewNetworkService.self)
        let url = bundle.url(forResource: "WeMapResponse", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let response = HTTPURLResponse(
            url: URL(string: "google.fr")!,
            statusCode: 200, httpVersion: nil,
            headerFields: nil)!
        return Just((data, response)).setFailureType(to: URLError.self).eraseToAnyPublisher()
    }
}
