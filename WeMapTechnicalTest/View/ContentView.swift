//
//  ContentView.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 17/08/2022.
//

import SwiftUI
import Mapbox.MGLPointAnnotation

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewViewModel
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            MapView(viewModel: viewModel.mapViewViewModel)
                .edgesIgnoringSafeArea(.bottom)
                
            
            VStack {
                Spacer()
                
                TextField("Search", text: $viewModel.searchTerms)
                    .padding()
                    .background(.white)
                    .clipShape(Capsule())
                    .disabled(true)
                    .onTapGesture {
                        self.showAlert = true
                    }
                    .padding()

            }
        }
        .alert("We're so sorry", isPresented: $showAlert, actions: {
            Button("Try this function") {
                self.viewModel.fetchPoi()
            }
            Button("OK") {
                self.showAlert = false
            }
        }, message: {
            Text("This feature require subscribtion to our Premium plans.\n You're lucky, it's only\n10,000$ / month\nTry this feature now!")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PreviewViewModel.contentViewViewModel)
    }
}
