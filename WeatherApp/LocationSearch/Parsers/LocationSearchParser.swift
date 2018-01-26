//
//  SearchListCityParser.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

class LocationSearchParser: LocationSearchParserProtocol {
    func parse(data: Data?) -> [Location]? {
        
        guard let responseData = data else {
            return nil
        }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                print("error trying to convert data to JSON")
                
                return nil
            }
            
            guard let searchApi = json["search_api"] as? [String : AnyObject] else {
                
                return nil
            }
            
            guard let result = searchApi["result"] as? [[String : Any]] else {
                
                return nil
            }
            
            var locationList : [Location] = []
        
            for item in result {
                
                var areaName = ""
                var country = ""
                var region = ""
                    
                if let areaNames = item["areaName"] as? [[String : String]] {
                    
                    if areaNames.count > 0 {
                        areaName = areaNames.first!["value"]!
                    }
                }
                
                if let countries = item["country"] as? [[String : String]] {
                    
                    if countries.count > 0 {
                        country = countries.first!["value"]!
                    }
                }
                
                if let regions = item["region"] as? [[String : String]] {
                    
                    if regions.count > 0 {
                        region = regions.first!["value"]!
                    }
                }
                
                locationList.append(Location(areaName: areaName, country: country, region: region))
            }
           
            return locationList
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
}
