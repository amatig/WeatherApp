//
//  LocationWeatherService.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

class LocationWeatherService: LocationWeatherServiceProtocol {
    
    private enum Constants {
        static let serviceName = "weather.ashx"
    }
    
    private let baseURL: String
    private let accessKey: String
    private let networking: Networking
    private let locationWeatherParserProtocol: LocationWeatherParserProtocol
    
    init(baseURL: String, accessKey: String, networking: Networking, locationWeatherParserProtocol: LocationWeatherParserProtocol) {
        self.baseURL = baseURL
        self.accessKey = accessKey
        self.networking = networking
        self.locationWeatherParserProtocol = locationWeatherParserProtocol
    }
    
    func fetch(querySearch: String, success: @escaping (Forecast) -> (), failure: @escaping (LocationWeatherError) -> ()) {
        
        let queryEncoded = querySearch.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let endPoint = "\(baseURL)/\(Constants.serviceName)?key=\(accessKey)&q=\(queryEncoded)&format=json&num_of_days=5"
       
        networking.httpGet(endpoint: endPoint, success: { data in
            guard data != nil else {
                failure(.generic)
                return
            }
            
            let forecastModel = LocationWeatherParser().parse(data: data)
            
            if forecastModel != nil {
                success(forecastModel!)
            } else {
                failure(.generic)
            }
            
        }) { error in
            failure(.generic)
        }
    }
}
