//
//  LocationSearchParserTests.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import XCTest
@testable import WeatherApp

class LocationSearchParserTests: XCTestCase {
    
    var parser: LocationSearchParser!
    
    override func setUp() {
        super.setUp()
        parser = LocationSearchParser()
    }
    
    override func tearDown() {
        parser = nil
        super.tearDown()
    }
    
    func test_GivenEmptyData_WhenParse_ThenLocationsNil() {
        
        let locations = parser.parse(data: nil)
        
        XCTAssertNil(locations)
    }
  
    func test_GivenCorrectData_WhenParse_ThenLocationsNotNil() {
        
        
        let base64 = ResourseHelper().givenLocationSearchBase64Response()
        let locations = parser.parse(data: Data(base64Encoded: base64))
        
        XCTAssertNotNil(locations)
    }
   
    func test_GivenMalformedJSONData_WhenParse_ThenLocationsNil() {
        
        //<http>generic html error</http>
        
        let locations = parser.parse(data: Data(base64Encoded: "PGh0dHA+Z2VuZXJpYyBodG1sIGVycm9yPC9odHRwPg=="))
        
        XCTAssertNil(locations)
    }
    
}
