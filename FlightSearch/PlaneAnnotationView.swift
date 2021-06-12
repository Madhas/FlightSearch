//
//  FlightAnnotationView.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 08.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import MapKit

final class PlaneAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        image = .plane
        frame.size = CGSize(width: 35, height: 35)
        isEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
