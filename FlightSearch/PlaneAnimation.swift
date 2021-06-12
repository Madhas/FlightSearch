//
//  PlaneAnimation.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 12.06.2021.
//  Copyright © 2021 home.com. All rights reserved.
//

import MapKit

final class PlaneAnimation {

    let fromLocation: Flight.Location
    let toLocation: Flight.Location
    let camera: MKMapCamera
    var duration: Double = 7
    private(set) var inProgess = false
    
    weak var view: MKAnnotationView?
    private let calculator: FlightPathCalculator
    
    private var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval = 0
    private var directionForward = true
    
    init(from: Flight.Location, to: Flight.Location, camera: MKMapCamera) {
        fromLocation = from
        toLocation = to
        self.camera = camera
        
        let startCoordinate = CLLocationCoordinate2D(latitude: from.latitude, longitude: from.longitude)
        let finishCoordinate = CLLocationCoordinate2D(latitude: to.latitude, longitude: to.longitude)
        
        let startPoint = MKMapPoint(startCoordinate)
        let endPoint = MKMapPoint(finishCoordinate)
        let boundingRect = MKMapRect(start: from, finish: to)
        
        calculator = FlightPathCalculator(boundingRect: Rect(rect: boundingRect),
                                          start: Point(point: startPoint),
                                          end: Point(point: endPoint))
    }
    
    func start() {
        inProgess = true
        startTime = CACurrentMediaTime()
        directionForward = true
        
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(tick(_:)))
            displayLink?.add(to: .main, forMode: .default)
        }
    }
    
    func stop() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func tick(_ link: CADisplayLink) {
        guard let annotation = view?.annotation as? PlaneAnnotation else { return }
        
        let passed = CACurrentMediaTime() - startTime
        let progress: Double
        if directionForward {
            progress = passed / duration
        } else {
            progress = 1 - passed / duration
        }
        
        guard progress <= 1, progress >= 0 else {
            startTime = CACurrentMediaTime()
            directionForward.toggle()
            return
        }
        
        let center = calculator.point(from: progress)
        let angle = calculator.angle(from: progress) - (camera.heading * .pi / 180)
        
        annotation.coordinate = center.mapPoint.coordinate
        
        view?.transform = CGAffineTransform(rotationAngle: CGFloat(directionForward ? angle : angle + .pi))
    }
}
