//
//  LocationWeatherServiceStub.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation
@testable import WeatherApp

class LocationWeatherServiceStub: LocationWeatherServiceProtocol {
    var forecastFetchedStub: Forecast?
    
    func fetch(querySearch: String, success: @escaping (Forecast) -> (), failure: @escaping (LocationWeatherError) -> ()) {
        
        if let forecast = forecastFetchedStub {
            success(forecast)
        }
    }
}
