//
//  LocationSearchParserProtocol.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

protocol LocationSearchParserProtocol {
    func parse(data: Data?) -> [Location]?
}
