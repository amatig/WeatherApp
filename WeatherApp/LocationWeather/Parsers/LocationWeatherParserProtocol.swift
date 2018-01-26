//
//  LocationWeatherParserProtocol.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

protocol LocationWeatherParserProtocol {
    func parse(data: Data?) -> Forecast?
}
