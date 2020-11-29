//
//  FlightSearchRouter.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 29.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

protocol FlightSearchModuleOutput: AnyObject {
    
}

final class FlightSearchRouter {

    private let client: HTTPClient
    
    private weak var controller: UIViewController?
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func assembleModule() -> UIViewController {
        let placesService = PlacesService(client: client)
        
        let controller = FlightSearchController()
        let presenter = FlightSearchPresenter(placesService: placesService)
        
        controller.viewOutput = presenter
        presenter.viewInput = controller
        presenter.moduleOutput = self
        self.controller = controller
        
        return NavigationController(rootViewController: controller)
    }
}

// MARK: FlightSearchModuleOutput

extension FlightSearchRouter: FlightSearchModuleOutput {
    
}
