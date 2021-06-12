//
//  PlaneAnnotation.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 08.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class PlaneAnnotation: NSObject, MKAnnotation {

    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    init(coordinate: Flight.Location) {
        let startCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        self.coordinate = startCoordinate
        
        super.init()
    }
}
