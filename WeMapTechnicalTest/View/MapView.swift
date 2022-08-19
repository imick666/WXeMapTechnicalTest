//
//  MapView.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 17/08/2022.
//

import SwiftUI
import Mapbox
import CoreLocation

struct MapView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MGLMapView {
        print("Loading")
        let styleUrl = URL(string: "https://api.maptiler.com/maps/streets/style.json?key=\(Credential.mapTileKey.rawValue)")!
        let mapView = MGLMapView(frame: .zero, styleURL: styleUrl)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.logoView.isHidden = true
        mapView.showsScale = true
        mapView.scaleBarUsesMetricSystem = true
        
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: MGLMapView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func test() -> MapView {
        return self
    }
    
    final class Coordinator: NSObject, MGLMapViewDelegate {
        
        var control : MapView
        
        init(_ control: MapView) {
            self.control = control
        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
            
        }
        
    }
}
