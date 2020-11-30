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

extension Flight.Location {

    static var saintPetersburg: Flight.Location {
        Flight.Location(latitude: 60.142708398306475, longitude: 29.961299028713075)
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
