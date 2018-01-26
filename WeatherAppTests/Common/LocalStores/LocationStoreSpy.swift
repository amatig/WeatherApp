//
//  LocationStoreSpy.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 17/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation
@testable import WeatherApp

class LocationStoreSpy: LocationLocalStore {
    
    var lastLocationSavedSpy: Location?
    
    func fetch() -> [Location] {
        return []
    }
    
    func save(location: Location) -> Bool {
        lastLocationSavedSpy = location
        return true
    }
}
