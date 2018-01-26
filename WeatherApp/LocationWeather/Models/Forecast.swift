//
//  Forecast.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

/// The weather forecast of an amount of days
/// and the detailed current conditions
struct Forecast {
    let weather: [Weather]
    let currentCondition: CurrentCondition
}
