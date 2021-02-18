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
    
    var name: String
    var iata: String
    var airportName: String?
    var location: Location
}

extension Flight.Location: Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

extension Flight {

    static var saintPetersburg: Flight {
        Flight(name: "Saint Petersburg",
               iata: "LED",
               airportName: "Pulkovo",
               location: .init(latitude: 59.799825, longitude: 30.266915))
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
