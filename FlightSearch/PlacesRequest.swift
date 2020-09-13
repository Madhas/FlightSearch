//
//  PlacesRequest.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 13.09.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

struct Places: Request {
    
    let term: String
    
    let urlPath = "places"
    let responseSerializer = JSONResponseSerializer<[Flight]>()
    
    var parameters: [String : Any]? {
        let locale = Bundle.preferredLocalizations(from: Bundle.main.localizations).first!
        return ["term": term, "locale": locale]
    }
    
    init(term: String) {
        self.term = term
    }
}
