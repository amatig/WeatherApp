//
//  LocationWeatherParser.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

class LocationWeatherParser: LocationWeatherParserProtocol {
    func parse(data: Data?) -> Forecast? {
        
        guard let responseData = data else {
            return nil
        }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                print("Error trying to convert data to JSON")
                return nil
            }
            
            guard let dataResult = json["data"] as? [String : AnyObject] else {
                return nil
            }
            
            guard let currentConditionsJson = dataResult["current_condition"] as? [[String : AnyObject]] else {
                
                return nil
            }
            
            guard let currentConditionJson = currentConditionsJson.first else {
                return nil
            }
            
            guard let weathers = dataResult["weather"] as? [[String : AnyObject]] else {
                return nil
            }
            
            let currentConditionModel = parseCurrentCondition(json: currentConditionJson)
            let weathersModel = parseWeathers(json: weathers)
            let forecast = Forecast(weather: weathersModel, currentCondition: currentConditionModel)
            
            return forecast
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
    
    func parseCurrentCondition(json : [String : AnyObject]) -> CurrentCondition {
        
        let observationTime = json["observation_time"] as? String  ?? ""
        let tempC = json["temp_C"] as? String  ?? ""
        var weatherIconUrl = ""
        var weatherDesc = ""
        let windspeedKmph = json["windspeedKmph"] as? String  ?? ""
        let precipMM = json["precipMM"] as? String  ?? ""
        let humidity = json["humidity"] as? String  ?? ""
        let visibility = json["visibility"] as? String  ?? ""
        
        if let weatherIconUrls = json["weatherIconUrl"] as? [[String : String]] {
            
            if weatherIconUrls.count > 0 {
                weatherIconUrl = weatherIconUrls.first!["value"]!
            }
        }
        
        if let weatherDescs = json["weatherDesc"] as? [[String : String]] {
            
            if weatherDescs.count > 0 {
                weatherDesc = weatherDescs.first!["value"]!
            }
        }
        
        return CurrentCondition(observationTime: observationTime, tempC: tempC, weatherIconUrl: weatherIconUrl, weatherDesc: weatherDesc, windspeedKmph: windspeedKmph, precipMM: precipMM, humidity: humidity, visibility: visibility)
    }
    
    func parseWeathers(json : [[String : AnyObject]]) -> [Weather] {
        
        var weathers : [Weather] = []
        
        for item in json {
            
            let maxtempC = item["maxtempC"] as? String  ?? ""
            let mintempC = item["mintempC"] as? String  ?? ""
            let date = item["date"] as? String  ?? ""
            
            let hourlyModel = parseHourly(json: item["hourly"] as! [[String : AnyObject]])
            let weatherModel = Weather(maxtempC: maxtempC, mintempC: mintempC, date: date, hourly: hourlyModel)
            
            weathers.append(weatherModel)
        }
        
        return weathers
    }
    
    func parseHourly(json : [[String : AnyObject]]) -> [Hourly] {
        
        var hourlies : [Hourly] = []
        
        for item in json {
            
            var weatherIconUrl = ""
            var weatherDesc = ""
            
            if let weatherIconUrls = item["weatherIconUrl"] as? [[String : String]] {
                
                if weatherIconUrls.count > 0 {
                    weatherIconUrl = weatherIconUrls.first!["value"]!
                }
            }
            
            if let weatherDescs = item["weatherDesc"] as? [[String : String]] {
                
                if weatherDescs.count > 0 {
                    weatherDesc = weatherDescs.first!["value"]!
                }
            }
            
            let hourlyModel = Hourly(weatherIconUrl: weatherIconUrl, weatherDesc: weatherDesc)
            
            hourlies.append(hourlyModel)
        }
        
        return hourlies
    }
}
