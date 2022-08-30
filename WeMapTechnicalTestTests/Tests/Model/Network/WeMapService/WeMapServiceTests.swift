//
//  WeMapServiceTests.swift
//  WeMapTechnicalTestTests
//
//  Created by Mickael Ruzel on 19/08/2022.
//

import XCTest
import Combine
@testable import WeMapTechnicalTest

// Those tests are not exhaustive.

class WeMapServiceTests: XCTestCase {
    
    // MARK: - Properties

    var sut: WeMapService?
    var subscriptions: Set<AnyCancellable>?
    
    // MARK: - SetUp / TearDown
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        subscriptions = Set<AnyCancellable>()
        
    }
    
    override func tearDownWithError() throws {
        
        sut = nil
        subscriptions = nil
        try super.tearDownWithError()
        
    }
    
    // MARK: - Methodes
    
    // MARK: - Tests
    
    func testWeMapService_OnFetchData_DataIsDecoded() {
        let service = NetworkServiceMock<WeMapResponse>(expectedReponse: .good, expectedData: .good)
        let client = NetworkClient<WeMapResponse>(service: service)
        sut = WeMapService(client: client)
        
        let expectation = expectation(description: "Wait for response")
        
        sut?.fetchPois(for: "")
            .sink(receiveCompletion: { completion in
                guard case .finished = completion else {
                    XCTFail()
                    return
                }
                expectation.fulfill()
            }, receiveValue: { result in
                XCTAssertEqual(result[0].title, "Bus urbains - TAM")
                XCTAssertEqual(result[0].mediaUrl, URL(string: "https://busUrbainTam.fr"))
            })
            .store(in: &subscriptions!)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testWeMapService_OnFetchData_BadResponseOccured() {
        let service = NetworkServiceMock<WeMapResponse>(expectedReponse: .bad(expectedError: .accessDenied), expectedData: .good)
        let client = NetworkClient<WeMapResponse>(service: service)
        sut = WeMapService(client: client)
        
        let expectation = expectation(description: "Wait for response")
        
        sut?.fetchPois(for: "")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else {
                    XCTFail()
                    return
                }
                expectation.fulfill()
                
                XCTAssertEqual(error as! WMNetworkError, WMNetworkError.accessDenied)
            }, receiveValue: { _ in })
            .store(in: &subscriptions!)
        
        wait(for: [expectation], timeout: 0.1)
    }
    

}
