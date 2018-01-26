//
//  LocationSearchViewControllerTests.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import XCTest
@testable import WeatherApp

class LocationSearchViewControllerTests: XCTestCase {
    
    var controller: LocationSearchViewController!
    var localStoreSpy: LocationStoreSpy!
    var serviceStub: LocationSearchServiceStub!
    
    override func setUp() {
        super.setUp()
        controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchListLocation") as! LocationSearchViewController
        localStoreSpy = LocationStoreSpy()
        serviceStub = LocationSearchServiceStub()
        controller.locationStore = localStoreSpy
        controller.locationSearchService = serviceStub
    }
    
    override func tearDown() {
        localStoreSpy = nil
        serviceStub = nil
        controller = nil
        super.tearDown()
    }
    
    func test_GivenSearchBarHasText_WhenButtonClicked_ThenTableViewShowsResult() {
        let searchBar = givenSearchBarHasText()
        
        controller.searchBarSearchButtonClicked(searchBar)
        
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_GivenViewIsDisplayingOneLocation_WhenDidSelectRow_ThenSaveLocation() {
        let location = Location(areaName: "Milan", country: "Italy", region: "Lombardia")
        controller.locations = [location]
        controller.loadViewIfNeeded()
        
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertNotNil(localStoreSpy.lastLocationSavedSpy)
    }
}

// MARK: - test steps
extension LocationSearchViewControllerTests {
    
    func givenSearchBarHasText() -> UISearchBar {
        let location = Location(areaName: "Milan", country: "Italy", region: "Lombardia")
        serviceStub.locationsStub = [location]
        
        controller.loadViewIfNeeded()
        let searchBar = controller.searchController.searchBar
        searchBar.text = "Milano"
        
        return searchBar
    }
}
