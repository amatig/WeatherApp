//
//  PreferredLocationsViewControllerTests.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import XCTest
@testable import WeatherApp

class PreferredLocationsViewControllerTests: XCTestCase {
    
    var controller: PreferredLocationsViewController!
    var localStoreStub: LocationLocalStoreStub!
    
    override func setUp() {
        super.setUp()
        controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreferredLocations") as! PreferredLocationsViewController
        localStoreStub = LocationLocalStoreStub()
        controller.locationStore = localStoreStub
    }
    
    override func tearDown() {
        localStoreStub = nil
        controller = nil
        super.tearDown()
    }
    
    func test_GivenOneLocationInStore_WhenViewWillAppear_ThenTableViewHasOneRow() {
        let location = Location(areaName: "Milan", country: "Italy", region: "Lombardia")
        localStoreStub.locationsToFetchStub = [location]
        
        controller.loadViewIfNeeded()
        controller.viewWillAppear(false)
        
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 1)
    }
}
