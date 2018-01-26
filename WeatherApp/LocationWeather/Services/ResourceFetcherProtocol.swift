//
//  ResourceFetcherProtocol.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 17/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit

enum ResourceFetcherError: Error {
    case generic
}

protocol ResourceFetcherProtocol {
    func fetchImage(from url: URL, success: @escaping (UIImage) -> (), failure: @escaping (ResourceFetcherError) -> ())
}
