//
//  FakeData.swift
//  WeMapTechnicalTestTests
//
//  Created by Mickael Ruzel on 19/08/2022.
//

import Foundation
@testable import WeMapTechnicalTest

/// Generate fake data for tests.
///
/// The .json file must be in the same direcoty of this class and be named exactely as the
/// object.
///
///     ex :
///         MyFakeData.json
///         MyFakeData.swift
final class FakeData<T: Decodable> {

    //  swiftlint:disable force_try
    static var goodData: Data {
        let bundle = Bundle(for: FakeData.self)
        let url = bundle.url(forResource: "\(T.self)", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static var badData: Data {
        return "Bonjour".data(using: .utf8)!
    }
}
