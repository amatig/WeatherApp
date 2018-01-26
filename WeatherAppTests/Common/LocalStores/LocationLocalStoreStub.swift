//
//  LocationLocalStoreStub.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 17/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation
@testable import WeatherApp

class LocationLocalStoreStub: LocationLocalStore {
    var locationsToFetchStub = [Location]()
    
    func fetch() -> [Location] {
        return locationsToFetchStub
    }
    
    func save(location: Location) -> Bool {
        return true
    }
}
