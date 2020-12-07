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
        let rect = MKMapRect(start: start.location, finish: finish.location)
        let insets = UIEdgeInsets(top: 100, left: 50, bottom: 100, right: 50)
        mapView.setVisibleMapRect(rect, edgePadding: insets, animated: false)
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
    
    private func addPath(from start: Flight, to finish: Flight) {
        let routeOverlay = PathOverlay(start: start.location, finish: finish.location, type: .route)
        let flightOverlay = PathOverlay(start: start.location, finish: finish.location, type: .flight)
        
        mapView.addOverlay(routeOverlay)
        mapView.addOverlay(flightOverlay)
    }
}

// MARK: MapViewInput

extension MapController: MapViewInput {
    
    func show(start: Flight, finish: Flight) {
        showRegionBetween(start: start, finish: finish)
        addAnnotations(start: start, finish: finish)
        addPath(from: start, to: finish)
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? PathOverlay {
            switch overlay.type {
            case .route:
                return PathOverlayRenderer(overlay: overlay)
            case .flight:
                return FlightOverlayRenderer(overlay: overlay)
            }
        }
        
        return MKOverlayRenderer()
    }
}
