//
//  MapRouter.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 30.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

protocol MapModuleOutput: AnyObject {
    
}

protocol MapNavigator: AnyObject {
}

final class MapModule {

    private let client: HTTPClient
    
    private weak var navigator: MapNavigator!
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    static func assemble(client: HTTPClient, flight: Flight) -> UIViewController {
        let module = MapModule(client: client)
        let controller = MapController()
        let presenter = MapPresenter(flight: flight)
        
        controller.viewOutput = presenter
        presenter.viewInput = controller
        presenter.moduleOutput = module
        module.navigator = controller
        
        return controller
    }
}

extension MapModule: MapModuleOutput {

    
}
