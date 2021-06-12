//
//  FlightMapOverlay.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class AirportAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    private let iata: String
    
    private(set) lazy var image = drawImage()
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        iata = title
    }

    func drawImage() -> UIImage {
        let view = UIView(frame: CGRect(origin: .zero, size: AirportAnnotationView.imageSize))
        view.backgroundColor = .accent
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        
        let label = UILabel()
        label.text = iata
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.sizeToFit()
        label.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(label)
        
        return UIGraphicsImageRenderer(size: AirportAnnotationView.imageSize).image { ctx in
            view.layer.render(in: ctx.cgContext)
        }
    }
}
