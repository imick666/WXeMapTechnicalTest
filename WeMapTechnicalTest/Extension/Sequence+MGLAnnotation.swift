//
//  Sequence+MGLPointAnnotation.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 20/08/2022.
//

import Foundation
import Mapbox.MGLPointAnnotation

extension Sequence where Element: MGLAnnotation {

    /// Return the center coordinate of all elements.
    var centerCoordinate: CLLocationCoordinate2D {
        let centerLat = minLattitude + ((maxLattitude - minLattitude) / 2)
        let centerLong = minLongitude + ((maxLongitude - minLongitude) / 2)

        return CLLocationCoordinate2D(latitude: centerLat, longitude: centerLong)
    }

    /// return the minimal lattitude of all elements
    var minLattitude: CLLocationDegrees {
        return self.map { $0.coordinate.latitude }.min() ?? 0
    }

    /// return the maximal lattitude of all the elements
    var maxLattitude: CLLocationDegrees {
        return self.map { $0.coordinate.latitude }.max() ?? 0
    }

    /// return the minimal longitude of all the elements
    var minLongitude: CLLocationDegrees {
        return self.map { $0.coordinate.longitude }.min() ?? 0
    }

    /// return the maximal longitude of all the elements
    var maxLongitude: CLLocationDegrees {
        return self.map { $0.coordinate.longitude }.max() ?? 0
    }

    /// return the distance between the the furthest elements
    /// - Warning: The distance is un feet
    var maxDistance: CLLocationDistance {
        let point1 = CLLocation(latitude: minLattitude, longitude: minLongitude)
        let point2 = CLLocation(latitude: maxLattitude, longitude: maxLongitude)

        return point1.distance(from: point2) * 3.28
    }

}

extension Sequence where Element: MGLAnnotation {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.minLongitude == rhs.minLongitude &&
        lhs.minLattitude == rhs.minLattitude
    }

    static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs.minLattitude != rhs.minLattitude &&
        lhs.minLongitude != rhs.minLongitude
    }
}
