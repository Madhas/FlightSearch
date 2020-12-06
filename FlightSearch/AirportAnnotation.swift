//
//  FlightMapOverlay.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class AirportAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
}
