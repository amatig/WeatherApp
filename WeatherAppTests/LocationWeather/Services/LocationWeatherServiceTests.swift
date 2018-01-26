//
//  LocationWeatherServiceTests.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import XCTest
@testable import WeatherApp

class LocationWeatherServiceTests: XCTestCase {
    
    var networking: NetworkingStub!
    var parser: LocationWeatherParserStub!
    
    override func setUp() {
        super.setUp()
        networking = NetworkingStub()
        parser = LocationWeatherParserStub()
    }
    
    override func tearDown() {
        networking = nil
        parser = nil
        super.tearDown()
    }
    
    func test_GivenBaseURLAndAccessKey_WhenFetch_ThenEndpointCorrect() {
        
        let service = LocationWeatherService(baseURL: "https://api.worldweatheronline.com/premium/v1", accessKey: "2c3e67b2886848d38c3102002171209", networking: networking, locationWeatherParserProtocol: parser)
        
        
        service.fetch(querySearch: "milano", success: { locations in
            // empty
        }) { error in
            // empty
        }
        
        let expectedEndpoint = "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=2c3e67b2886848d38c3102002171209&q=milano&format=json&num_of_days=5"
        
        XCTAssertEqual(networking.endpoint, expectedEndpoint)
    }
    
    func test_GivenNetworkingError_WhenFetch_ThenError() {
        var forecastFetched: Forecast?
        var errorFetched: LocationWeatherError?
        
        networking.errorStub = .generic
        networking.dataStub = nil
        
        let forecast = givenForecastModel()
        
        let service = LocationWeatherService(baseURL: "fakeURL", accessKey: "fakeKey", networking: networking, locationWeatherParserProtocol: parser)
        
        service.fetch(querySearch: "milano", success: { locations in
            forecastFetched = forecast
        }) { error in
            errorFetched = error
        }
        
        XCTAssertNotNil(errorFetched)
        XCTAssertNil(forecastFetched)
    }
}

// MARK: - Utils
extension LocationWeatherServiceTests {

    func givenForecastModel() -> Forecast {
        return ForecastStubFactory.makeForecastStub()
    }
}
