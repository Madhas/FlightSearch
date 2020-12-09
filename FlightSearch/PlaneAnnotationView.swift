//
//  FlightAnnotationView.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 08.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class PlaneAnnotationView: MKAnnotationView {
    
    static private let animationDuration: Double = 30
    
    private let calculator = FlightPathCalculator()
    private var displayLink: CADisplayLink?
    
    private var startTime: CFTimeInterval = 0

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        image = .plane
        frame.size = CGSize(width: 35, height: 35)
        isEnabled = false

        if let annotation = annotation as? PlaneAnnotation {
            calculator.update(boundingRect: Rect(rect: annotation.boundingRect),
                              start: Point(point: annotation.startPoint),
                              end: Point(point: annotation.endPoint))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 11.0, *)
    override func prepareForDisplay() {
        super.prepareForDisplay()
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(tick(_:)))
            startTime = CACurrentMediaTime()
            displayLink?.add(to: .main, forMode: .common)
        }
    }
    
    @objc private func tick(_ displayLink: CADisplayLink) {
        guard let annotation = annotation as? PlaneAnnotation else { return }
        
        let passed = CACurrentMediaTime() - startTime
        let progress = passed / PlaneAnnotationView.animationDuration
        guard progress <= 1 else {
            return
        }
        
        let center = calculator.point(from: progress)
        annotation.coordinate = center.mapPoint.coordinate
    }
}
