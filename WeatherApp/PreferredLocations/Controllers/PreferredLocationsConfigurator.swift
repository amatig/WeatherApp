//
//  PreferedLocationsConfigurator.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit

/// Used to inject dependencies into the corresponding controller
class PreferredLocationsConfigurator {
    
    var controller : PreferredLocationsViewController?
    
    func configure(viewController: PreferredLocationsViewController) {
        
        self.controller = viewController
        setupPreferredLocation()
    }
    
    func setupPreferredLocation() {
        self.controller!.locationStore = CDLocationLocalStore(coreDataStack: coreDataStack())
    }
    
    func coreDataStack() -> CoreDataStack {
        return (UIApplication.shared.delegate as! AppDelegate).coreDataStack
    }
}
