//
//  WeMapTechnicalTestApp.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 17/08/2022.
//

import SwiftUI

@main
struct WeMapTechnicalTestApp: App {
    
    let contentViewViewModel = ContentViewViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: contentViewViewModel)
        }
    }
}
