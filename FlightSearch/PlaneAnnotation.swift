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
    var startTime: Double = CACurrentMediaTime()
    var directionForward = true
    
    let startPoint: MKMapPoint
    let endPoint: MKMapPoint
    let boundingRect: MKMapRect
    
    let camera: MKMapCamera
    
    init(start: Flight.Location, finish: Flight.Location, camera: MKMapCamera) {
        let startCoordinate = CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitude)
        let finishCoordinate = CLLocationCoordinate2D(latitude: finish.latitude, longitude: finish.longitude)
        
        coordinate = startCoordinate
        startPoint = MKMapPoint(startCoordinate)
        endPoint = MKMapPoint(finishCoordinate)
        boundingRect = MKMapRect(start: start, finish: finish)
        
        self.camera = camera
        
        super.init()
    }
}
