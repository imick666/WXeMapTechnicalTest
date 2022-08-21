//
//  ContentView.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 17/08/2022.
//

import SwiftUI
import Mapbox.MGLPointAnnotation

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewViewModel()
    @State var selectedAnnotation: MGLPointAnnotation? = nil
    
    
    var body: some View {
        ZStack {
            MapView(viewModel: viewModel.mapViewViewModel)
                
            
            VStack {
                Spacer()
                
                Button {
                    viewModel.fetchPoi()
                } label: {
                    Text("Fetch Pois")
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
