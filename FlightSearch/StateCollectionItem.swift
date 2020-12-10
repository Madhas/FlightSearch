//
//  StateCollectionItem.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 10.12.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import Foundation

final class StateCollectionItem {

    let errorText: String?
    
    init(errorText: String) {
        self.errorText = errorText
    }
    
    init() {
        errorText = nil
    }
}
