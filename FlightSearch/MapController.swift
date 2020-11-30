//
//  MapContrller.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 30.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

protocol MapViewInput: AnyObject {
    
    func show(start: Flight.Location, finish: Flight.Location)
}

class MapController: UIViewController {
    
    var viewOutput: MapViewOutput!
    
    private var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        viewOutput.touch()
    }
}

// MARK: MapViewInput

extension MapController: MapViewInput {
    
    func show(start: Flight.Location, finish: Flight.Location) {
        let latRadius = fabs(start.latitude - finish.latitude) / 2
        let lonRadius = fabs(start.longitude - finish.longitude) / 2
        let span = max(latRadius, lonRadius) * 3.5
        var region = MKCoordinateRegion()
        region.center.latitude = max(start.latitude, finish.latitude) - latRadius
        region.center.longitude = max(start.longitude, finish.longitude) - lonRadius
        region.span.latitudeDelta = span
        region.span.longitudeDelta = span
        
        mapView.setRegion(region, animated: false)
    }
}
