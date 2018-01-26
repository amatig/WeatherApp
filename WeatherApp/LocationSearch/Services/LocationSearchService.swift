//
//  LocationSearchService.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

class LocationSearchService: LocationSearchServiceProtocol {
    
    private enum Constants {
        static let serviceName = "search.ashx"
    }
    
    private let baseURL: String
    private let accessKey: String
    private let networking: Networking
    private let locationSearchParserProtocol: LocationSearchParserProtocol
    
    init(baseURL: String, accessKey: String, networking: Networking, locationSearchParserProtocol: LocationSearchParserProtocol) {
        self.baseURL = baseURL
        self.accessKey = accessKey
        self.networking = networking
        self.locationSearchParserProtocol = locationSearchParserProtocol
    }
    
    func fetch(querySearch: String, success: @escaping ([Location]) -> (), failure: @escaping (LocationSearchError) -> ()) {
        
        let queryEncoded = querySearch.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let endPoint = "\(baseURL)/\(Constants.serviceName)?key=\(accessKey)&q=\(queryEncoded)&format=json"
        
        networking.httpGet(endpoint: endPoint, success: { data in
            guard data != nil else {
                failure(.generic)
                return
            }
            
            let locations = LocationSearchParser().parse(data: data)
            
            if locations != nil {
                success(locations!)
            } else {
                failure(.generic)
            }
      
        }) { error in
            failure(.generic)
        }
    }
}
