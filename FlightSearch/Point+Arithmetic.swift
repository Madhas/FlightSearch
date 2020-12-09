//
//  CGPoint+Arithmetic.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

extension Point {

    static func *(left: Double, right: Point) -> Point {
        Point(x: left * right.x, y: left * right.y)
    }
    
    static func +(left: Point, right: Point) -> Point {
        Point(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func -(left: Point, right: Point) -> Point {
        Point(x: left.x - right.x, y: left.y - right.y)
    }
}
