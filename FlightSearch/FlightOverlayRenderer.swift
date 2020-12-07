//
//  FlightOverlayRenderer.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 07.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class FlightOverlayRenderer: MKOverlayRenderer {
    
    private let planeImage = UIImage.plane
    private let calculator = FlightPathCalculator()
    private var displayLink: CADisplayLink?
    
    private var currentProgress: CGFloat = 0
    private var step: CGFloat = 0.05

    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        guard let image = planeImage.cgImage, let overlay = overlay as? PathOverlay else { return }
        
        let boundingRect = self.rect(for: overlay.boundingMapRect)
        let startPoint = self.point(for: overlay.startPoint)
        let endPoint = self.point(for: overlay.endPoint)
        calculator.update(boundingRect: boundingRect, start: startPoint, end: endPoint)
        
        let size = 60 / zoomScale
        let center = calculator.point(from: 0.5)
        let rect = CGRect(x: center.x - size / 2,
                          y: center.y - size / 2,
                          width: size,
                          height: size)
        
        context.draw(image, in: rect)
    }
}
