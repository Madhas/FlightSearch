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

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        isEnabled = false
        drawView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawView() {
        guard let ttitle = annotation?.title, let title = ttitle else { return }
        
        let view = UIView(frame: CGRect(origin: .zero, size: AirportAnnotationView.imageSize))
        view.backgroundColor = .accent
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.sizeToFit()
        label.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(label)
        
        image = UIGraphicsImageRenderer(size: AirportAnnotationView.imageSize).image { ctx in
            view.layer.render(in: ctx.cgContext)
        }
    }
}
