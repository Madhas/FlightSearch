//
//  MapPresenter.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 30.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import Foundation

protocol MapViewOutput: AnyObject {
    
    func touch()
}

final class MapPresenter: MapViewOutput {
    
    var moduleOutput: MapModuleOutput!
    weak var viewInput: MapViewInput!
    
    private let flight: Flight
    
    init(flight: Flight) {
        self.flight = flight
    }
    
    func touch() {
        viewInput.show(start: .saintPetersburg, finish: flight)
    }
}
