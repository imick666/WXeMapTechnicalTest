//
//  Poi.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation
import Mapbox.MGLAnnotation

final class Poi: NSObject, Decodable, MGLAnnotation {
    
    // MARK: - Properties
    
    let title: String?
    let poiDescription: String
    let coordinate: CLLocationCoordinate2D
    let address: String
    let mediaUrl: URL?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try values.decode(String.self, forKey: .title)
        poiDescription = try values.decode(String.self, forKey: .poiDescription)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        let lattitude = try values.decode(Double.self, forKey: .latitude)
        self.coordinate = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        address = try values.decode(String.self, forKey: .address)
        mediaUrl = try? values.decode(URL.self, forKey: .mediaURL)
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
