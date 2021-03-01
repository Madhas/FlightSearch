//
//  LoadingView.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 18.02.2021.
//  Copyright © 2021 home.com. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .backgroundPrimary
        
        let size: CGFloat = 20
        shapeLayer.bounds = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        shapeLayer.strokeColor = UIColor.accent.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: shapeLayer.bounds.midX, y: shapeLayer.bounds.midY),
                                       radius: size / 2,
                                       startAngle: 0,
                                       endAngle: 3 * .pi / 4,
                                       clockwise: false).cgPath
        layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.byValue = CGFloat.pi * 2
        animation.repeatCount = .infinity
        animation.duration = 0.75
        shapeLayer.add(animation, forKey: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
