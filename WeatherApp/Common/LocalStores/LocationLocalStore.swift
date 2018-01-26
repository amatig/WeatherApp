//
//  LocationLocalStore.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

protocol LocationLocalStore {
    
    /// @return the list of all locations saved locally
    func fetch() -> [Location]
    
    /// @return true if save was successful, false otherwise
    func save(location: Location) -> Bool
}
