//
//  MapView.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 17/08/2022.
//

import SwiftUI
import Mapbox
import Combine

struct MapView: UIViewRepresentable {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: MapViewViewModel
    
    // MARK: - Protocol Conformence
    
    func makeUIView(context: Context) -> MGLMapView {
        let styleUrl = URL(string: "https://api.maptiler.com/maps/streets/style.json?key=\(Credential.mapTileKey.rawValue)")!
        let view = MGLMapView(frame: .zero, styleURL: styleUrl)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.logoView.isHidden = true
        view.showsScale = true
        view.scaleBarUsesMetricSystem = true
        
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MGLMapView, context: Context) {
        uiView.addAnnotations(viewModel.annotations)
        
        let camera = MGLMapCamera(lookingAtCenter: viewModel.annotations.centerCoordinate, acrossDistance: viewModel.annotations.maxDistance, pitch: 15, heading: 0)
        
        uiView.setCamera(camera, withDuration: 4, animationTimingFunction: nil)
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // MARK: - Methodes
    
    // MARK: - Coordinator
    
    final class Coordinator: NSObject, MGLMapViewDelegate {
        
        var control : MapView
        
        init(_ control: MapView) {
            self.control = control
        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
            control.viewModel.getDeviceRegion { location in
                mapView.setCenter(location, zoomLevel: 4, animated: true)
            }
        }
        
        
    }
}
