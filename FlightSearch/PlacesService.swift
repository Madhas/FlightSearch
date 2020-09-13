//
//  PlacesService.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 13.09.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

final class PlacesService {

    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadPlaces(query: String, completion: @escaping (Result<[Flight]>) -> Void) {
        let request = PlacesRequest(term: query)
        client.send(request: request, completion: completion)
    }
}

