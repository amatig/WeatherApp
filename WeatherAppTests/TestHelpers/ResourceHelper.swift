//
//  ResourceHelper.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

class ResourseHelper {
    
    func givenLocationSearchBase64Response() -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "locationSearchBase64", ofType: "")!
        return try! String(contentsOfFile: path, encoding: .utf8)
    }
    
    func givenForecastBase64Response() -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "forecasthBase64", ofType: "")!
        return try! String(contentsOfFile: path, encoding: .utf8)
    }
}
