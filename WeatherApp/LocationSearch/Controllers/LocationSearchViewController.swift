//
//  LocationSearchViewController.swift
//  WeatherApp
//
//  Created by Giovanni Amati on 16/09/2017.
//  Copyright © 2017 Giovanni Amati All rights reserved.
//

import UIKit
import CoreData

/// Allows the user to search for a list of area names
class LocationSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var locations : [Location] = []
    var locationSearchService : LocationSearchServiceProtocol!
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

        title = "Search locations"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        setupSearchController()
    }

}

// MARK: - private
extension LocationSearchViewController {
    
    @IBAction func onTapClose(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupSearchController() {
        
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = true
    }
    
    fileprivate func fetchListLocation(search: String) {
        
        locationSearchService.fetch(querySearch: search, success: { [weak self] locations in
            
            self?.locations = locations
            self?.tableView.reloadData()
            
        }) { error in
            print(error)
        }
    }
    
    fileprivate func setup() {
        LocationSearchConfigurator().configure(viewController: self)
    }
    
    fileprivate func saveAndDismiss(location: Location) {
        if locationStore.save(location: location) {
            dismiss(animated: true, completion: nil)
        } else {
            print("Error trying to save location")
        }
    }
}

extension LocationSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        fetchListLocation(search: searchBar.text!)
        searchController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension LocationSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = locations[indexPath.row]
        
        let text = "\(location.areaName), \(location.region), \(location.country)"
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = text
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocationSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let location = locations[indexPath.row]
        
        saveAndDismiss(location: location)
    }
}
