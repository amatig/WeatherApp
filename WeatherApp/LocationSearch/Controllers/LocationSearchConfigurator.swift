//
//  LocationSearchServiceConfigurator.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit

/// Used to inject dependencies into the corresponding controller
class LocationSearchConfigurator {
    
    var controller : LocationSearchViewController?
    
    func configure(viewController: LocationSearchViewController) {
        
        self.controller = viewController
        setupLocationSearch()
    }
    
    func setupLocationSearch() {
        
        let networking = URLSessionNetworking()
        let locationSearchParserProtocol = LocationSearchParser()
        
        let locationSearchService = LocationSearchService(baseURL: Configuration.baseURL, accessKey: Configuration.accessKey, networking: networking, locationSearchParserProtocol: locationSearchParserProtocol)
        
        self.controller!.locationSearchService = locationSearchService
        self.controller!.locationStore = CDLocationLocalStore(coreDataStack: coreDataStack())
    }
    
    func coreDataStack() -> CoreDataStack {
        return (UIApplication.shared.delegate as! AppDelegate).coreDataStack
    }
}
