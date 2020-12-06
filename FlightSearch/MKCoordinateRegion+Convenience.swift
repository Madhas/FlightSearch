//
//  MKCoordinateRegion+Convenience.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

extension MKCoordinateRegion {

    init(startLocation: Flight.Location, finishLocation: Flight.Location) {
        self.init()
        
        let latRadius = fabs(startLocation.latitude - finishLocation.latitude) / 2
        let lonRadius = fabs(startLocation.longitude - finishLocation.longitude) / 2
        let span = min(max(latRadius, lonRadius) * 3.5, 180)
        
        center.latitude = max(startLocation.latitude, finishLocation.latitude) - latRadius
        center.longitude = max(startLocation.longitude, finishLocation.longitude) - lonRadius
        self.span.latitudeDelta = span
    }
}
