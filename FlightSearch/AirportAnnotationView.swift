//
//  AirportAnnotationView.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 06.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class AirportAnnotationView: MKAnnotationView {
    
    static let imageSize = CGSize(width: 36, height: 20)
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let annotation = self.annotation as? AirportAnnotation else { return }
            image = annotation.image
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
