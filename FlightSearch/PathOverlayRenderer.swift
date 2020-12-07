//
//  PathOverlayRenderer.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class PathOverlayRenderer: MKOverlayPathRenderer {

    private let calculator: FlightPathCalculator
    
    override init(overlay: MKOverlay) {
        calculator = FlightPathCalculator()
        
        super.init(overlay: overlay)
        
        strokeColor = .accent
        lineWidth = 1.5
        lineCap = .round
        lineDashPattern = [3, 4]
    }

    override func createPath() {
        guard let overlay = overlay as? PathOverlay else { return }
        
        let rect = self.rect(for: overlay.boundingMapRect)
        let startPoint = self.point(for: overlay.startPoint)
        let endPoint = self.point(for: overlay.endPoint)

        calculator.update(boundingRect: rect, start: startPoint, end: endPoint)
        self.path = calculator.cubicCurve().cgPath
    }
}
