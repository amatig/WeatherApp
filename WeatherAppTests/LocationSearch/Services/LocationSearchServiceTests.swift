//
//  LocationSearchServiceTests.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import XCTest
@testable import WeatherApp

class LocationSearchServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
       
    }
    
    override func tearDown() {
       
        super.tearDown()
    }
    
    func test_GivenBaseURLAndAccessKey_WhenFetch_ThenEndpointCorrect() {
        
        
        let networking = NetworkingStub()
        let parser = LocationSearchParserStub()
        
        
        let service = LocationSearchService(baseURL: "https://api.worldweatheronline.com/premium/v1", accessKey: "2c3e67b2886848d38c3102002171209", networking: networking, locationSearchParserProtocol: parser)
        
        
        service.fetch(querySearch: "milano", success: { locations in
            // empty
        }) { error in
            // empty
        }
        
        let expectedEndpoint = "https://api.worldweatheronline.com/premium/v1/search.ashx?key=2c3e67b2886848d38c3102002171209&q=milano&format=json"
        
        XCTAssertEqual(networking.endpoint, expectedEndpoint)
    }
    
    func test_GivenNetworkingError_WhenFetchLocationSearch_ThenError() {
        var locationsFetched: [Location]?
        var errorFetched: LocationSearchError?
        
        let networking = NetworkingStub()
        networking.errorStub = .generic
        networking.dataStub = nil
        
    
        let parser = LocationSearchParserStub()
        
        let locations = [Location(areaName: "milano", country: "italia", region: "lombardia")]
        parser.locationsStub = locations
        
        let service = LocationSearchService(baseURL: "fakeURL", accessKey: "fakeKey", networking: networking, locationSearchParserProtocol: parser)
        
        service.fetch(querySearch: "milano", success: { locations in
            locationsFetched = locations
        }) { error in
            errorFetched = error
        }
    
        XCTAssertNotNil(errorFetched)
        XCTAssertNil(locationsFetched)
    }
}
