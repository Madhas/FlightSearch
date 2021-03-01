//
//  FlightPathCalculator.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 07.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

final class FlightPathCalculator {

    private var boundingRect: Rect
    private var startPoint: Point
    private var endPoint: Point
    
    private var ctrlPoint1: Point {
        if max(boundingRect.width, boundingRect.height) / min(boundingRect.width, boundingRect.height) < 2 {
            let addend = startPoint.x > endPoint.x ? -amplitude * 2 : amplitude * 2
            return Point(x: startPoint.x + addend, y: startPoint.y)
        } else if boundingRect.width > boundingRect.height {
            let addendX = startPoint.x > endPoint.x ? -boundingRect.width / 3 : boundingRect.width / 3
            let addendY = startPoint.y > endPoint.y ? amplitude : -amplitude
            return Point(x: startPoint.x + addendX, y: startPoint.y + addendY)
        } else {
            let addendX = startPoint.x > endPoint.x ? amplitude : -amplitude
            let addendY = startPoint.y > endPoint.y ? -boundingRect.height / 3 : boundingRect.height / 3
            return Point(x: startPoint.x + addendX, y: startPoint.y + addendY)
        }
    }
    
    private var ctrlPoint2: Point {
        if max(boundingRect.width, boundingRect.height) / min(boundingRect.width, boundingRect.height) < 2 {
            let addend = startPoint.x > endPoint.x ? amplitude * 2 : -amplitude * 2
            return Point(x: endPoint.x + addend, y: endPoint.y)
        } else if boundingRect.width > boundingRect.height {
            let addendX = startPoint.x > endPoint.x ? boundingRect.width / 3 : -boundingRect.width / 3
            let addendY = startPoint.y > endPoint.y ? -amplitude : amplitude
            return Point(x: endPoint.x + addendX, y: endPoint.y + addendY)
        } else {
            let addendX = startPoint.x > endPoint.x ? -amplitude : amplitude
            let addendY = startPoint.y > endPoint.y ? boundingRect.height / 3 : -boundingRect.height / 3
            return Point(x: endPoint.x + addendX, y: endPoint.y + addendY)
        }
    }
    
    private var amplitude: Double {
        max(boundingRect.width, boundingRect.height) * 0.3
    }
    
    convenience init() {
        self.init(boundingRect: .zero, start: .zero, end: .zero)
    }
    
    init(boundingRect: Rect, start: Point, end: Point) {
        self.boundingRect = boundingRect
        self.startPoint = start
        self.endPoint = end
    }
    
    func update(boundingRect: Rect, start: Point, end: Point) {
        self.boundingRect = boundingRect
        self.startPoint = start
        self.endPoint = end
    }
    
    func cubicCurve() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint.cgPoint)
        path.addCurve(to: endPoint.cgPoint, controlPoint1: ctrlPoint1.cgPoint, controlPoint2: ctrlPoint2.cgPoint)
        return path
    }
    
    func point(from t: Double) -> Point {
        let p0 = pow((1 - t), 3) * startPoint
        let p1 = 3 * pow((1 - t), 2) * t * ctrlPoint1
        let p2 = 3 * (1 - t) * pow(t, 2) * ctrlPoint2
        let p3 = pow(t, 3) * endPoint
        
        return p0 + p1 + p2 + p3
    }
    
    func angle(from t: Double) -> Double {
        let currentDeriv = cubicCurveDerivative(from: t)
        return atan2(currentDeriv.y, currentDeriv.x)
    }
 
    private func cubicCurveDerivative(from t: Double) -> Point {
        let d1 = 3 * pow((1 - t), 2) * (ctrlPoint1 - startPoint)
        let d2 = 6 * (1 - t) * t * (ctrlPoint2 - ctrlPoint1)
        let d3 = 3 * pow(t, 2) * (endPoint - ctrlPoint2)
        return d1 + d2 + d3
    }
}
