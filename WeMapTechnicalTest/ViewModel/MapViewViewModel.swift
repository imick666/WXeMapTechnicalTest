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
    
    @Published private(set) var annotations = [MGLPointAnnotation]()
    
    // MARK: - Init
    
    init() {
        
    }
    
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
        let annotations = pois.map { poi -> MGLPointAnnotation in
            let annotation = MGLPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: poi.latitude, longitude: poi.longitude)
            annotation.title = poi.name
            
            return annotation
        }
        
        self.annotations = annotations
    }
    
}
