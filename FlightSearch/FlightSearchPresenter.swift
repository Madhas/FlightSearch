//
//  FlightSearchPresenter.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 13.09.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import Foundation

protocol FlightSearchViewOutput {
    
    func didEnter(query: String)
    func didSelect(flight: Flight)
}

final class FlightSearchPresenter: FlightSearchViewOutput {

    var moduleOutput: FlightSearchModuleOutput!
    weak var viewInput: FlightSearchViewInput!
    
    private let placesService: PlacesService
    
    init(placesService: PlacesService) {
        self.placesService = placesService
        self.placesService.throttle = 0.5
    }
    
    func didEnter(query: String) {
        guard query.count > 0 else {
            placesService.cancelLastRequest()
            viewInput.show(items: [])
            return
        }
        
        placesService.loadPlaces(query: query) { result in
            switch result {
            case .success(let places):
                let items = places.map {
                    FlightCollectionItem(flight: $0)
                }
                DispatchQueue.main.async {
                    self.viewInput.show(items: items)
                    if items.isEmpty {
                        self.viewInput.show(error: LocalError.notFound)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewInput.show(error: error)
                }
            }
        }
    }
    
    func didSelect(flight: Flight) {
        moduleOutput.showMap(for: flight)
    }
}
