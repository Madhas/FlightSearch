//
//  MapContrller.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 30.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

protocol MapViewInput: AnyObject {
    
    func show(start: Flight, finish: Flight)
}

class MapController: UIViewController {
    
    var viewOutput: MapViewOutput!
    
    private var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        
        viewOutput.touch()
    }
    
    private func showRegionBetween(start: Flight, finish: Flight) {
        let latRadius = fabs(start.location.latitude - finish.location.latitude) / 2
        let lonRadius = fabs(start.location.longitude - finish.location.longitude) / 2
        let span = max(latRadius, lonRadius) * 3.5
        var region = MKCoordinateRegion()
        region.center.latitude = max(start.location.latitude, finish.location.latitude) - latRadius
        region.center.longitude = max(start.location.longitude, finish.location.longitude) - lonRadius
        region.span.latitudeDelta = span
        region.span.longitudeDelta = span
        
        mapView.setRegion(region, animated: false)
    }
    
    private func addAnnotations(start: Flight, finish: Flight) {
        let startCoordinate = CLLocationCoordinate2D(latitude: start.location.latitude, longitude: start.location.longitude)
        let startAnnotation = AirportAnnotation(coordinate: startCoordinate,
                                                title: start.iata)
        let finishCoordinate = CLLocationCoordinate2D(latitude: finish.location.latitude, longitude: finish.location.longitude)
        let finishAnnotation = AirportAnnotation(coordinate: finishCoordinate,
                                                 title: finish.iata)
        
        mapView.addAnnotation(startAnnotation)
        mapView.addAnnotation(finishAnnotation)
    }
}

// MARK: MapViewInput

extension MapController: MapViewInput {
    
    func show(start: Flight, finish: Flight) {
        showRegionBetween(start: start, finish: finish)
        addAnnotations(start: start, finish: finish)
    }
}

// MARK: MKMapViewDelegate

extension MapController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is AirportAnnotation {
            return AirportAnnotationView(annotation: annotation, reuseIdentifier: String(describing: AirportAnnotationView.self))
        }
        
        return nil
    }
}
