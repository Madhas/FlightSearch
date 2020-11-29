//
//  PlacesService.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 13.09.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

final class PlacesService {
    
    var throttle: TimeInterval = 0

    private let client: HTTPClient
    
    private var lastRequestData: (String, (Result<[Flight]>) -> Void)?
    private var placesWorkItem: DispatchWorkItem?
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadPlaces(query: String, completion: @escaping (Result<[Flight]>) -> Void) {
        if placesWorkItem != nil {
            lastRequestData = (query, completion)
        } else if throttle > 0 {
            lastRequestData = (query, completion)
            let workItem = DispatchWorkItem(block: { [weak self] in
                defer { self?.placesWorkItem = nil }
                guard let (query, completion) = self?.lastRequestData else {
                    return
                }
                let request = PlacesRequest(term: query)
                self?.client.send(request: request, completion: completion)
            })
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + throttle, execute: workItem)
            placesWorkItem = workItem
        } else {
            let request = PlacesRequest(term: query)
            client.send(request: request, completion: completion)
        }
    }
}

