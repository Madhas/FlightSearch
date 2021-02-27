//
//  Error.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 19.02.2021.
//  Copyright © 2021 home.com. All rights reserved.
//

import Foundation

enum LocalError: Error, LocalizedError {
    
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return .flightsNotFound
        }
    }
}
