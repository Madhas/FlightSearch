//
//  PlaneAnnotation.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 08.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class PlaneAnnotation: NSObject, MKAnnotation {

    @objc dynamic var coordinate: CLLocationCoordinate2D
    let startPoint: MKMapPoint
    let endPoint: MKMapPoint
    let boundingRect: MKMapRect
    
    init(start: Flight.Location, finish: Flight.Location) {
        let startCoordinate = CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitude)
        let finishCoordinate = CLLocationCoordinate2D(latitude: finish.latitude, longitude: finish.longitude)
        
        coordinate = startCoordinate
        startPoint = MKMapPoint(startCoordinate)
        endPoint = MKMapPoint(finishCoordinate)
        boundingRect = MKMapRect(start: start, finish: finish)
        
        super.init()
    }
}
