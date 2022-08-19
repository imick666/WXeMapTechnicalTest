//
//  Poi.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 18/08/2022.
//

import Foundation

struct Poi: Decodable {
    let address: String
    let category: Int
    let country: String?
    let created, description: String?
    let externalData, facebookURL, geoEntityShape: String?
    let id: Int
    let imageURL: String?
    let latitude: Double
    let likeCount: Int
    let linkURL: String?
    let longitude: Double
    let mediaCredits: String
    let mediaThumbnailURL, mediaType, mediaURL: String?
    let name: String
    let openingHours, phone: String?
    let state, status: Int
    let tags: [String]
    let timezone: String?
    let twitterURL: String?
    let type: Int
    let updated: String?
    let user: Int
}
