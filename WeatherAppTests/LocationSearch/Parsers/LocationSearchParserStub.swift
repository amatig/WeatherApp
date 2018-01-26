//
//  LocationSearchParserStub.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation
@testable import WeatherApp

class LocationSearchParserStub: LocationSearchParserProtocol {
    var locationsStub: [Location]?
    
    func parse(data: Data?) -> [Location]? {
        return locationsStub
    }
}
