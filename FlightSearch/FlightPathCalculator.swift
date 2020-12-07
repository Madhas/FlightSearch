//
//  FlightPathCalculator.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 07.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

final class FlightPathCalculator {

    private var boundingRect: CGRect
    private var startPoint: CGPoint
    private var endPoint: CGPoint
    
    private var ctrlPoint1: CGPoint {
        if boundingRect.width > boundingRect.height {
            return CGPoint(x: abs(startPoint.x - boundingRect.width / 3),
                           y: boundingRect.midY + amplitude)
        } else {
            return CGPoint(x: boundingRect.midX + amplitude,
                           y: abs(startPoint.y - boundingRect.height / 3))
        }
    }
    
    private var ctrlPoint2: CGPoint {
        if boundingRect.width > boundingRect.height {
            return CGPoint(x: abs(startPoint.x - boundingRect.width * 2 / 3),
                           y: boundingRect.midY - amplitude)
        } else {
            return CGPoint(x: boundingRect.midX - amplitude,
                           y: abs(startPoint.y - boundingRect.height * 2 / 3))
        }
    }
    
    private var amplitude: CGFloat {
        max(min(boundingRect.height, boundingRect.width), max(boundingRect.height, boundingRect.width) / 4)
    }
    
    init() {
        boundingRect = .zero
        startPoint = .zero
        endPoint = .zero
    }
    
    init(boundingRect: CGRect, start: CGPoint, end: CGPoint) {
        self.boundingRect = boundingRect
        self.startPoint = start
        self.endPoint = end
    }
    
    func update(boundingRect: CGRect, start: CGPoint, end: CGPoint) {
        self.boundingRect = boundingRect
        self.startPoint = start
        self.endPoint = end
    }
    
    func cubicCurve() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: ctrlPoint1, controlPoint2: ctrlPoint2)
        return path
    }
    
    func point(from t: CGFloat) -> CGPoint {
        let p0 = pow((1 - t), 3) * startPoint
        let p1 = 3 * pow((1 - t), 2) * t * ctrlPoint1
        let p2 = 3 * (1 - t) * pow(t, 2) * ctrlPoint2
        let p3 = pow(t, 3) * endPoint
        return p0 + p1 + p2 + p3
    }
}
