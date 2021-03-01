//
//  PathOverlayRenderer.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class PathOverlayRenderer: MKOverlayPathRenderer {

    private let calculator = FlightPathCalculator()
    
    override init(overlay: MKOverlay) {
        super.init(overlay: overlay)
        
        strokeColor = .accent
        lineWidth = 1.5
        lineCap = .round
        lineDashPattern = [3, 4]
        
        guard let overlay = overlay as? PathOverlay else { return }
        
        let rect = Rect(rect:self.rect(for: overlay.boundingMapRect))
        let startPoint = Point(point: self.point(for: overlay.startPoint))
        let endPoint = Point(point: self.point(for: overlay.endPoint))
        calculator.update(boundingRect: rect, start: startPoint, end: endPoint)
    }

    override func createPath() {
        self.path = calculator.cubicCurve().cgPath
    }
}
