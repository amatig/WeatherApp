//
//  LocationWeatherParserStub.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import XCTest
@testable import WeatherApp

class LocationWeatherParserStub: LocationWeatherParserProtocol {
    var forecastStub: Forecast?
    
    func parse(data: Data?) -> Forecast? {
        return forecastStub
    }
}
