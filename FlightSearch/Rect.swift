//
//  Rect.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 09.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

struct Point {
    
    var x: Double
    var y: Double
}

struct Size {
    
    var width: Double
    var height: Double
}

struct Rect {
    
    var origin: Point
    var size: Size
}

extension Point {
    
    static var zero: Point {
        Point(x: 0, y: 0)
    }
    
    var cgPoint: CGPoint {
        CGPoint(x: x, y: y)
    }
    
    var mapPoint: MKMapPoint {
        MKMapPoint(x: x, y: y)
    }
    
    init(point: CGPoint) {
        x = Double(point.x)
        y = Double(point.y)
    }
    
    init(point: MKMapPoint) {
        x = point.x
        y = point.y
    }
}

extension Size {
    
    static var zero: Size {
        Size(width: 0, height: 0)
    }
    
    var cgSize: CGSize {
        CGSize(width: width, height: height)
    }
    
    var mapSize: MKMapSize {
        MKMapSize(width: width, height: height)
    }
    
    init(size: CGSize) {
        width = Double(size.width)
        height = Double(size.height)
    }
    
    init(size: MKMapSize) {
        width = size.width
        height = size.height
    }
}

extension Rect {
    
    static var zero: Rect {
        Rect(origin: .zero, size: .zero)
    }
    
    var cgRect: CGRect {
        CGRect(origin: origin.cgPoint, size: size.cgSize)
    }
    
    var mapRect: MKMapRect {
        MKMapRect(origin: origin.mapPoint, size: size.mapSize)
    }

    var width: Double {
        fabs(size.width)
    }
    
    var height: Double {
        fabs(size.height)
    }
    
    var minX: Double {
        min(origin.x, origin.x + size.width)
    }
    
    var maxX: Double {
        max(origin.x, origin.x + size.width)
    }
    
    var midX: Double {
        maxX - width / 2
    }
    
    var minY: Double {
        min(origin.y, origin.y + size.height)
    }
    
    var maxY: Double {
        max(origin.y, origin.y + size.height)
    }
    
    var midY: Double {
        maxY - height / 2
    }
    
    init(rect: CGRect) {
        origin = Point(point: rect.origin)
        size = Size(size: rect.size)
    }
    
    init(rect: MKMapRect) {
        origin = Point(point: rect.origin)
        size = Size(size: rect.size)
    }
}
