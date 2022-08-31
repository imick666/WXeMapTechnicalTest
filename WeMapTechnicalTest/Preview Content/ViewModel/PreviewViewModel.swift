//
//  PreviewViewModel.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 31/08/2022.
//

import Foundation

final class PreviewViewModel {

    static var contentViewViewModel: ContentViewViewModel {
        let networkService = PreviewNetworkService()
        let client = NetworkClient<WeMapResponse>(service: networkService)
        let weMapService = WeMapService(client: client)
        return ContentViewViewModel(weMapService: weMapService)
    }

}
