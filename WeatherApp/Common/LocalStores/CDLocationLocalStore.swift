//
//  CDLocationLocalStore.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit
import CoreData

class CDLocationLocalStore: LocationLocalStore {
    
    var coreDataStack: CoreDataStack!
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func fetch() -> [Location] {
        
        var cdLocations = [CDLocation]()
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        do {
            cdLocations = try coreDataStack.managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            cdLocations = []
        }
        
        return locations(from: cdLocations)
    }
    
    func save(location: Location) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "CDLocation",
                                                in: coreDataStack.managedContext)!
        
        let cdLocation = CDLocation(entity: entity, insertInto: coreDataStack.managedContext)
        cdLocation.areaName = location.areaName
        cdLocation.country = location.country
        cdLocation.region = location.region
        
        do {
            try coreDataStack.managedContext.save()
            return true
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
}

fileprivate extension CDLocationLocalStore {
    
    func locations(from cdLocations: [CDLocation]) -> [Location] {
        var locationsToReturn = [Location]()
        for cdLocation in cdLocations {
            let location = Location(areaName: cdLocation.areaName!, country: cdLocation.country!, region: cdLocation.region!)
            locationsToReturn.append(location)
        }
        return locationsToReturn
    }
}
