//
//  MapPresenter.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 30.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import Foundation

protocol MapViewOutput: AnyObject {
    
}

final class MapPresenter: MapViewOutput {
    
    var moduleOutput: MapModuleOutput!
    weak var viewInput: MapViewInput!
    
}
