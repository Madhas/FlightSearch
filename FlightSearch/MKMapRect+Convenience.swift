//
//  MKMapRect+Convenience.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

extension MKMapRect {

    init(start: Flight.Location, finish: Flight.Location) {
        let startPoint = MKMapPoint(CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitude))
        let finishPoint = MKMapPoint(CLLocationCoordinate2D(latitude: finish.latitude, longitude: finish.longitude))
        
        let origin = MKMapPoint(x: min(startPoint.x, finishPoint.x), y: min(startPoint.y, finishPoint.y))
        let size = MKMapSize(width: fabs(startPoint.x - finishPoint.x), height: fabs(startPoint.y - finishPoint.y))
        
        self.init(origin: origin, size: size)
    }
}

