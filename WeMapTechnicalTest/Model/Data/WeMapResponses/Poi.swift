//
//  Poi.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation
import Mapbox.MGLAnnotation

final class Poi: MGLPointAnnotation, Decodable {

    // MARK: - Properties

    let poiDescription: String
    let address: String
    let mediaUrl: URL?

    // MARK: - Init

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.poiDescription = try values.decode(String.self, forKey: .poiDescription).fromHtml ?? "No Description"
        address = try values.decode(String.self, forKey: .address).replacingOccurrences(of: ", ", with: ",\n")
        mediaUrl = try? values.decode(URL.self, forKey: .mediaURL)

        super.init()

        self.title = try values.decode(String.self, forKey: .title)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        let lattitude = try values.decode(Double.self, forKey: .latitude)
        self.coordinate = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case title = "name"
        case address
        case poiDescription = "description"
        case latitude, longitude
        case mediaURL = "media_url"
    }
}
