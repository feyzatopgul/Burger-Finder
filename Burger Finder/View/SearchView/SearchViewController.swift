//
//  SearchViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
    
    let searchViewModel = SearchViewModel()
    let placeSearchBar = UISearchBar()
    let locationSearchBar = UISearchBar()

    let placesTableView = UITableView()
    typealias DataSource = UITableViewDiffableDataSource<PlacesSection, Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PlacesSection, Place>
    lazy var dataSource = createDataSource()
    
    let mapView = MKMapView()
    var mapListBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backButtonDisplayMode = .minimal
        
        //Configure right bar button as mapButton
        configureMapListButton()
        
        //Configure placeSearchBar
        configurePlaceSearchBar()
        
        //Configure locationSearchBar
        configureLocationSearchBar()
        
        //Configure placesTableView
        configurePlacesTableView()
        
        //Configure mapView
        configureMapView()
        
        //Fetch places data
        getPlaces(search: "", location: "")
        
        //Update placesTableView
        applySnapshot()
    }
    
    //Fetch place data when user searches something
    func getPlaces(search: String, location: String) {
        searchViewModel.fetchSearchedPlaces(search: search, location: location) {[weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Error in getting searched places: \(error) ")
            } else {
                DispatchQueue.main.async {
                    //Update placesTableView
                    self.applySnapshot()
                    //Update mapView
                    self.createAnnotations(places: self.searchViewModel.searchedPlaces)
                }
            }
        }
    }
    //Deselect selected annotations when after view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let selectedAnnotations = mapView.selectedAnnotations
        for annotation in selectedAnnotations {
            mapView.deselectAnnotation(annotation, animated: true)
        }
    }
}
