//
//  MapRouter.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 30.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

protocol MapModuleOutput: AnyObject {
    
}

final class MapRouter {

    private let client: HTTPClient
    
    private weak var controller: UIViewController?
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func assembleModule(flight: Flight) -> UIViewController {
        let controller = MapController()
        let presenter = MapPresenter(flight: flight)
        
        controller.viewOutput = presenter
        presenter.viewInput = controller
        presenter.moduleOutput = self
        self.controller = controller
        
        return controller
    }
}

extension MapRouter: MapModuleOutput {

    
}
