//
//  MapPresenter.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 30.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import Foundation

protocol MapViewOutput: AnyObject {
    
    func pathLocations() -> (start: Flight.Location, finish: Flight.Location)
}

final class MapPresenter: MapViewOutput {
    
    var moduleOutput: MapModuleOutput!
    weak var viewInput: MapViewInput!
    
    private let flight: Flight
    
    init(flight: Flight) {
        self.flight = flight
    }
    
    func pathLocations() -> (start: Flight.Location, finish: Flight.Location) {
        (.saintPetersburg, flight.location)
    }
}
