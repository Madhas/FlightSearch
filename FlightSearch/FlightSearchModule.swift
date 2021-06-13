//
//  FlightSearchRouter.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 29.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

protocol FlightSearchModuleOutput: AnyObject {
    
    func showMap(for flight: Flight)
}

protocol FlightSearchNavigator: AnyObject {
    
    func present(map: UIViewController)
}

final class FlightSearchModule {

    private let client: HTTPClient
    
    private weak var navigator: FlightSearchNavigator!
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    static func assemble(with client: HTTPClient) -> UIViewController {
        let placesService = PlacesService(client: client)
        
        let module = FlightSearchModule(client: client)
        let controller = FlightSearchController()
        let presenter = FlightSearchPresenter(placesService: placesService)
        
        controller.viewOutput = presenter
        presenter.viewInput = controller
        presenter.moduleOutput = module
        module.navigator = controller
        
        return controller
    }
}

// MARK: FlightSearchModuleOutput

extension FlightSearchModule: FlightSearchModuleOutput {
    
    func showMap(for flight: Flight) {
        let controller = MapModule.assemble(client: client, flight: flight)
        navigator.present(map: controller)
    }
}
