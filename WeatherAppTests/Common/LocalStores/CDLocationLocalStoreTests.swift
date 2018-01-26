//
//  CDLocationLocalStoreTests.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 17/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import XCTest
import CoreData
@testable import WeatherApp

class CDLocationLocalStoreTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var locationStore: CDLocationLocalStore!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStack(modelName: "WeatherApp", storeType: .inMemory)
        locationStore = CDLocationLocalStore(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        locationStore = nil
        coreDataStack = nil
        super.tearDown()
    }
    
    func test_GivenALocation_WhenSave_ThenOneRecordInStore() {
        let location = Location(areaName: "Milan", country: "Italy", region: "Lombardy")
        
        let saved = locationStore.save(location: location)
        
        XCTAssertTrue(saved)
        XCTAssertEqual(recordsCount(), 1)
    }
    
    func test_GivenALocationInStore_WhenFetch_ThenReturnTheLocation() {
        let location = Location(areaName: "Milan", country: "Italy", region: "Lombardy")
        givenALocationInStore(location: location)
        
        let fetchedLocationList = locationStore.fetch()
        guard let fetchedLocation = fetchedLocationList.first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(fetchedLocation.areaName, location.areaName)
        XCTAssertEqual(fetchedLocation.country, location.country)
        XCTAssertEqual(fetchedLocation.region, location.region)
    }
}

// MARK: - steps
fileprivate extension CDLocationLocalStoreTests {
    
    func givenALocationInStore(location: Location) {
        let entity = NSEntityDescription.entity(forEntityName: "CDLocation",
                                                in: coreDataStack.managedContext)!
        
        let cdLocation = CDLocation(entity: entity, insertInto: coreDataStack.managedContext)
        cdLocation.areaName = location.areaName
        cdLocation.country = location.country
        cdLocation.region = location.region
        
        do {
            try coreDataStack.managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func recordsCount() -> Int {
        var count = 0
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDLocation")
        do {
            count = try coreDataStack.managedContext.count(for: fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return count
    }
}
