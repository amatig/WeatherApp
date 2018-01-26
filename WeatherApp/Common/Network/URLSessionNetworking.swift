//
//  URLSessionNetworking.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import Foundation

class URLSessionNetworking: Networking {
    
    let session: URLSession
    
    init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func httpGet(endpoint: String, success: @escaping (Data?) -> (), failure: @escaping (NetworkingError) -> ()) {
        
        guard let url = URL(string: endpoint) else {
            failure(.invalidEndpoint)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    failure(.generic)
                }
                return
            }
            DispatchQueue.main.async {
                success(data)
            }
        }
        dataTask.resume()
    }
}
