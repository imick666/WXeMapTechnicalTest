//
//  CLLocationCoordinate2D+Equatable.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 20/08/2022.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
    }
}
