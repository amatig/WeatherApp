//
//  NetworkingStub.swift
//  WeatherAppTests
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation
@testable import WeatherApp

class NetworkingStub: Networking {
    
    var dataStub: Data?
    var errorStub: NetworkingError?
    var endpoint: String?
    
    func httpGet(endpoint: String, success: @escaping (Data?) -> (), failure: @escaping (NetworkingError) -> ()) {
        
        self.endpoint = endpoint
        
        if errorStub != nil {
            failure(errorStub!)
        } else {
            success(dataStub)
        }
    }
}
