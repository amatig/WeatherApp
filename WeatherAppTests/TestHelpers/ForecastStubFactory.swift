//
//  ForecastStubFactory.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 17/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation
@testable import WeatherApp

class ForecastStubFactory {
    class func makeForecastStub() -> Forecast {
        let hourly = Hourly(weatherIconUrl: "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0008_clear_sky_night.png", weatherDesc: "Clear")
        
        let currentCondition = CurrentCondition(observationTime: "01:00 PM", tempC: "22", weatherIconUrl: "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png", weatherDesc: "Partly cloudy", windspeedKmph: "0", precipMM: "0", humidity: "10", visibility: "15")
        
        let weather = Weather(maxtempC: "30", mintempC: "20", date: "2017-09-12", hourly: [hourly])
        
        let forecast = Forecast(weather: [weather], currentCondition: currentCondition)
        
        return forecast
    }
}
