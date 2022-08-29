//
//  ContentViewViewModel.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 19/08/2022.
//

import Foundation
import Combine
import CoreLocation

final class ContentViewViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var mapViewViewModel = MapViewViewModel()
    @Published var searchTerms = ""
    
    private var weMapService: WeMapService
    private var subscribtions = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(weMapService: WeMapService = WeMapService()) {
        self.weMapService = weMapService
    }
    
    // MARK: - Methodes
    
    func fetchPoi() {
        weMapService.fetchPois(for: searchTerms)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: return
                case .failure(let error): print(error.localizedDescription)
                }
            } receiveValue: { [unowned self] result in
                self.mapViewViewModel.setPois(result)
            }
            .store(in: &subscribtions)
    }
    
    
}
