//
//  LocationSearchServiceProtocol.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

enum LocationSearchError: Error {
    case generic
}

/// Search for area names for which there are weather forecasts available
protocol LocationSearchServiceProtocol {
    
    /// @param querySearch The location to search (e.g. "Milan", "London", etc.)
    func fetch(querySearch: String, success: @escaping ([Location]) -> (), failure: @escaping (LocationSearchError) -> ())
}
