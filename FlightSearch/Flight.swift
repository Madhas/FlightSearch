//
//  Flight.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 13.09.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import Foundation

struct Flight {
    
    struct Location {
        let latitude: Double
        let longitude: Double
    }
    
    let name: String
    let iata: String
    let airportName: String?
    let location: Location
}

extension Flight.Location: Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

extension Flight: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case iata
        case location
        case airportName = "airport_name"
    }
}
