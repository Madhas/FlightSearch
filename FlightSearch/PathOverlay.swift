//
//  PathOverlay.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class PathOverlay: NSObject, MKOverlay {
    
    enum `Type` {
        case route
        case flight
    }

    let coordinate: CLLocationCoordinate2D
    let boundingMapRect: MKMapRect
    
    let startPoint: MKMapPoint
    let endPoint: MKMapPoint
    let type: Type
    
    init(start: Flight.Location, finish: Flight.Location, type: Type) {
        let rect = MKMapRect(start: start, finish: finish)
        
        boundingMapRect = rect
        coordinate = MKMapPoint(x: rect.midX, y: rect.midY).coordinate
        
        startPoint = MKMapPoint(CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitude))
        endPoint = MKMapPoint(CLLocationCoordinate2D(latitude: finish.latitude, longitude: finish.longitude))
        
        self.type = type
        
        super.init()
    }
}
