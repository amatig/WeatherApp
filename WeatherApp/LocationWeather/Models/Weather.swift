//
//  Weather.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

/// The weather forecast of a day
struct Weather {
    let maxtempC: String
    let mintempC: String
    let date: String
    let hourly : [Hourly]
}
