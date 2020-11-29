//
//  MapContrller.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 30.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

protocol MapViewInput: AnyObject {
    
}

class MapController: UIViewController {
    
    var viewOutput: MapViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundPrimary
    }

}

// MARK: MapViewInput

extension MapController: MapViewInput {
    
}
