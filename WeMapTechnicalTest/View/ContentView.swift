//
//  ContentView.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 17/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewViewModel()
    
    var body: some View {
        ZStack {
            MapView(viewModel: viewModel.mapViewViewModel)
                .edgesIgnoringSafeArea(.bottom)
            
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
