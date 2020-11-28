//
//  FlightCollectionItem.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 28.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import Foundation

final class FlightCollectionItem {
    
    let flight: Flight
    
    var title: String {
        flight.name
    }
    
    var subtitle: String? {
        flight.airportName
    }
    
    var iata: String {
        flight.iata
    }
    
    init(flight: Flight) {
        self.flight = flight
    }
}
