//
//  HTTPConfiguration+Convenience.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 29.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import HTTPWrapper

extension HTTPConfiguration {

    static var `default`: HTTPConfiguration {
        HTTPConfiguration(baseUrl: "http://places.aviasales.ru/",
                          completionQueue: DispatchQueue(label: "com.home.FlightSearch.RequestCompletionQueue", qos: .userInitiated))
    }
}
