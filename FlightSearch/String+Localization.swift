//
//  String+Localization.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 28.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import Foundation

extension String {

    static var searchBarCancel: String {
        NSLocalizedString("common_cancel", comment: "")
    }
    
    static var searchPlaceholder: String {
        NSLocalizedString("flight_search_placeholder", comment: "")
    }
    
    static var flightsNotFound: String {
        NSLocalizedString("common_error_not_found", comment: "")
    }
}
