//
//  PlacesService.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 13.09.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

final class PlacesService {
    
    var throttle: TimeInterval = 0

    private let client: HTTPClient
    
    private var placesWorkItem: DispatchWorkItem?
    private var lastRequest: RequestToken?
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadPlaces(query: String, completion: @escaping (Result<[Flight]>) -> Void) {
        let completionBlock = { (result: Result<[Flight]>) in
            if case let .failure(error) = result, (error as NSError).code == NSURLErrorCancelled {
                return
            }
            
            completion(result)
        }
        
        if throttle > 0 {
            placesWorkItem?.cancel()
            let workItem = DispatchWorkItem(block: { [weak self] in
                let request = PlacesRequest(term: query)
                self?.lastRequest = self?.client.send(request: request, completion: completionBlock)
            })
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + throttle, execute: workItem)
            placesWorkItem = workItem
        } else {
            let request = PlacesRequest(term: query)
            lastRequest = client.send(request: request, completion: completionBlock)
        }
    }
    
    func cancelLastRequest() {
        lastRequest?.cancel()
        placesWorkItem?.cancel()
        
        lastRequest = nil
        placesWorkItem = nil
    }
}

