//
//  NetworkServiceMock.swift
//  WeMapTechnicalTestTests
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation
@testable import WeMapTechnicalTest
import Combine

/// This class is a mock for "NetworkService" that replace the usage of "URLSession" and
/// send the responses and the datas you want to test.
///
/// The decodable generic T will determine the fake data to use.
// swiftlint:disable line_length
final class NetworkServiceMock<T: Decodable>: PNetowrkService {

    // MARK: - Enums

    /// The expected response to test.
    ///
    enum ExpectedReponse {
        /// Good
        case good
        case bad(expectedError: WMNetworkError)

        var URLResponse: HTTPURLResponse {
            let url = URL(string: "google.fr")!
            switch self {
            case .good: return HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            case .bad(.notAuthentified): return HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: nil)!
            case .bad(.uknowned): return HTTPURLResponse(url: url, statusCode: 511, httpVersion: nil, headerFields: nil)!
            case .bad(.noResponse): return HTTPURLResponse(url: url, statusCode: 504, httpVersion: nil, headerFields: nil)!
            case .bad(.serverError): return HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
            case .bad(.ressourceNotFound): return HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
            case .bad(.accessDenied): return HTTPURLResponse(url: url, statusCode: 403, httpVersion: nil, headerFields: nil)!
            default: return HTTPURLResponse(url: url, statusCode: 600, httpVersion: nil, headerFields: nil)!
            }
        }
    }

    /// The expected data to test.
    enum ExpectedData {
        case good, bad

        var data: Data {
            switch self {
            case .good: return FakeData<T>.goodData
            case .bad: return FakeData<T>.badData
            }
        }
    }

    // MARK: - Properties

    private var expectedReponse: ExpectedReponse
    private var expectedData: ExpectedData

    // MARK: - Init

    /// Initialize a new instance of NetworkServiceMock
    init(expectedReponse: ExpectedReponse,
         expectedData: ExpectedData) {
        self.expectedReponse = expectedReponse
        self.expectedData = expectedData
    }

    // MARK: - Methodes

    /// Conformence to PNetworkService protocol.
    ///
    /// The URL can be empty, it will not be used.
    func fetchData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return Just((expectedData.data, expectedReponse.URLResponse)).setFailureType(to: URLError.self).eraseToAnyPublisher()
    }
}
