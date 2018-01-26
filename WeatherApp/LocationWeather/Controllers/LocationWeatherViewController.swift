//
//  LocationWeatherViewController.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit
import CoreData

/// It displays the forecast detail for a specific area
class LocationWeatherViewController: UIViewController {

    var location: Location!
    var locationWeatherService : LocationWeatherServiceProtocol!
    var resourceFetcher: ResourceFetcherProtocol!
    var forecast : Forecast?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var observationTimeLabel: UILabel!
    @IBOutlet weak var fullDescriptionLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Forecast"
        
        fetchWeather(search: location.areaName)
    }
}

// MARK: - private
extension LocationWeatherViewController {
    
    fileprivate func fetchWeather(search: String) {
        
        locationWeatherService.fetch(querySearch: search, success: {[weak self] forecast in
            
            self?.forecast = forecast
            self?.updateLayout()
            self?.table.reloadData()
            
        }) { error in
            print(error)
        }
    }
    
    func updateLayout() {
        
        guard let forecast = forecast else {
            return
        }
        
        cityLabel.text = location.areaName
        weatherDescLabel.text = forecast.currentCondition.weatherDesc
        temperatureLabel.text = "\(forecast.currentCondition.tempC)°"
        observationTimeLabel.text = forecast.currentCondition.observationTime
        
        let message = "Today: \(forecast.currentCondition.weatherDesc) currently. Wind is \(forecast.currentCondition.windspeedKmph) Kmph, Precipitation \(forecast.currentCondition.precipMM) MM, Humidity \(forecast.currentCondition.humidity)%, Visibility \(forecast.currentCondition.visibility) Km"
        
        fullDescriptionLabel.text = message
        
        update(imageView: thumbImageView, from: forecast.currentCondition.weatherIconUrl)
    }
    
    func update(imageView: UIImageView, from urlString: String) {
        resourceFetcher.fetchImage(from: URL(string: urlString)!, success: { image in
            imageView.image = image
        }, failure: { error in
            print("Error trying to fetch image: \(urlString)")
        })
    }
    
    fileprivate func setup() {
        LocationWeatherConfigurator().configure(viewController: self)
    }
}

// MARK: - UITableViewDataSource
extension LocationWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        var count = 0
        if let rows = forecast?.weather.count {
            count = rows
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weather = forecast!.weather[indexPath.row]
        
        // 12pm
        let midday = weather.hourly[4]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
        
        update(imageView: cell.thumbImageView, from: midday.weatherIconUrl)
        cell.dateLabel.text = indexPath.row == 0 ? "Today, 12pm" : "\(weather.date), 12pm"
        cell.minTempLabel.text = weather.mintempC
        cell.maxTempLabel.text = weather.maxtempC
        cell.weatherDescLabel.text = midday.weatherDesc
        
        return cell
    }
}
