//
//  MapViewViewModel.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 20/08/2022.
//

import Foundation
import Combine
import Mapbox.MGLPointAnnotation
import CoreLocation.CLGeocoder

final class MapViewViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var annotations = [MGLAnnotation]()

    // MARK: - Init

    init() { }

    // MARK: - Methodes

    func getDeviceRegion(completionHander: @escaping ( CLLocationCoordinate2D) -> Void) {
        guard let regionCode = Locale.current.regionCode else {
            return
        }

        CLGeocoder().geocodeAddressString(regionCode) {  marks, _ in
            guard let location = marks?.last?.location?.coordinate else {
                return
            }

            completionHander(location)
        }
    }

    func setPois(_ pois: [Poi]) {
        annotations = pois
    }
}
