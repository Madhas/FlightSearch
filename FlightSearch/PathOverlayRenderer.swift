//
//  PathOverlayRenderer.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class PathOverlayRenderer: MKOverlayPathRenderer {
    
    override init(overlay: MKOverlay) {
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
        
        let amp = max(min(rect.height, rect.width), max(rect.height, rect.width) / 4)
        let ctrlPoint1: CGPoint
        let ctrlPoint2: CGPoint
        
        if rect.width > rect.height {
            ctrlPoint1 = CGPoint(x: abs(startPoint.x - rect.width / 3),
                                 y: rect.midY + amp)
            ctrlPoint2 = CGPoint(x: abs(startPoint.x - rect.width * 2 / 3),
                                 y: rect.midY - amp)
        } else {
            ctrlPoint1 = CGPoint(x: rect.midX + amp,
                                 y: abs(startPoint.y - rect.height / 3))
            ctrlPoint2 = CGPoint(x: rect.midX - amp,
                                 y: abs(startPoint.y - rect.height * 2 / 3))
        }
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: ctrlPoint1, controlPoint2: ctrlPoint2)
        
        self.path = path.cgPath
    }
}
