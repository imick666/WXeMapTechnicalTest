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
        updateAnnotations(for: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // MARK: - Methodes
    
    private func annotationHasChanged(for mapView: MGLMapView) -> Bool {
        switch mapView.annotations {
        case .none: return true
        case .some(let annotations): return annotations != viewModel.annotations
        }
    }
    
    private func updateAnnotations(for mapView: MGLMapView) {
        guard annotationHasChanged(for: mapView) else { return }
        
        mapView.addAnnotations(viewModel.annotations)
        
        let camera = MGLMapCamera(lookingAtCenter: viewModel.annotations.centerCoordinate, acrossDistance: viewModel.annotations.maxDistance, pitch: 0, heading: 0)
        mapView.setCamera(camera, withDuration: 2, animationTimingFunction: nil)
        
    }
    
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
        
        func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
            return true
        }
        
        func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
            if let annotation = annotation as? Poi {
                return PoiCalloutView(annotation: annotation)
            }
            
            return nil
        }
        
    }
}
