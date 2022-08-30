//
//  WeMapResponseTests.swift
//  WeMapTechnicalTestTests
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import XCTest
@testable import WeMapTechnicalTest

class WeMapResponseTests: XCTestCase {
    
    func testDecodeJson() {
        
        do {
            let _ = try JSONDecoder().decode(WeMapResponse.self, from: FakeData<WeMapResponse>.goodData)
            XCTAssert(true)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
