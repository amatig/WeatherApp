//
//  LocationSearchServiceStub.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation
@testable import WeatherApp

class LocationSearchServiceStub: LocationSearchServiceProtocol {
    var locationsStub = [Location]()
    
    func fetch(querySearch: String, success: @escaping ([Location]) -> (), failure: @escaping (LocationSearchError) -> ()) {
        
        success(locationsStub)
    }
}
