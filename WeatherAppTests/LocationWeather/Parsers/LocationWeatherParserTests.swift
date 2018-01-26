//
//  LocationWeatherParserTests.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import XCTest
@testable import WeatherApp

class LocationWeatherParserTests: XCTestCase {
    
    var parser: LocationWeatherParser!
    
    override func setUp() {
        super.setUp()
        parser = LocationWeatherParser()
    }
    
    override func tearDown() {
        parser = nil
        super.tearDown()
    }
    
    func test_GivenEmptyData_WhenParse_ThenForecastNil() {
        
        let forecast = parser.parse(data: nil)
        
        XCTAssertNil(forecast)
    }
    
    func test_GivenCorrectData_WhenParse_ThenForecastNotNil() {
        
        
        let base64 = ResourseHelper().givenForecastBase64Response()
        let forecast = parser.parse(data: Data(base64Encoded: base64))
        
        XCTAssertNotNil(forecast)
    }
    
    func test_GivenMalformedJSONData_WhenParse_ThenForecastNil() {
        
        //<http>generic html error</http>
        
        let forecast = parser.parse(data: Data(base64Encoded: "PGh0dHA+Z2VuZXJpYyBodG1sIGVycm9yPC9odHRwPg=="))
        
        XCTAssertNil(forecast)
    }
    
    
}
