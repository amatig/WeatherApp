//
//  ResourceFetcher.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 17/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit

class ResourceFetcher: ResourceFetcherProtocol {
    
    var networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func fetchImage(from url: URL, success: @escaping (UIImage) -> (), failure: @escaping (ResourceFetcherError) -> ()) {
        
        networking.httpGet(endpoint: url.absoluteString, success: { data in
            
            guard let imageData = data,
                let image = UIImage(data: imageData) else {
                
                    failure(.generic)
                    return
            }
            success(image)
        }) { error in
            failure(.generic)
        }
    }
}
