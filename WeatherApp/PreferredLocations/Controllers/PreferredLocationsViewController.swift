//
//  PreferedLocationsViewController.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit
import CoreData

/// It displays the user preferred locations saved on local store 
class PreferredLocationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var preferredLocations: [Location] = []
    var locationStore: LocationLocalStore!
    
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

        title = "Preferred"
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "CellPrefered")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preferredLocations = locationStore.fetch()
        tableView.reloadData()
    }
}

// MARK: - private
extension PreferredLocationsViewController {
 
    fileprivate func setup() {
        PreferredLocationsConfigurator().configure(viewController: self)
    }
}

// MARK: - UITableViewDataSource
extension PreferredLocationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preferredLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = preferredLocations[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPrefered", for: indexPath)
        
        let text = "\(location.areaName), \(location.country), \(location.region)"
        cell.textLabel?.text = text
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PreferredLocationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let location = preferredLocations[indexPath.row]
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocationWeather") as! LocationWeatherViewController
        controller.location = location
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
