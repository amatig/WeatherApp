//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 18/10/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "WeatherApp", storeType: .sqlite)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
}
