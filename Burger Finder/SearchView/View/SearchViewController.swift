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
    
    let networkWarningLabel = UILabel()
    let refreshButton = UIButton()
    let spinnerView = UIActivityIndicatorView()
    
    var pendingRequestWorkItem: DispatchWorkItem?
    
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
        
        //Show loadingView before data is fetched from network
        configureAndShowLoadingView()
        
        //Configure refreshButton, spinnerView and networkWarningLabel for checking network status
        configureNetworkWarningLabel()
        configureRefreshButton()
        configureSpinner()
        
        //Hide loadingView if locations is not enabled
        searchViewModel.isLocationEnabled { [weak self] isEnabled in
            guard let self = self else {return}
            if !isEnabled{
                self.hideLoadingView()
            }
        }
        
        //Hide loadingView and show alert if network is not connected
        searchViewModel.isNetworkConnected { [weak self] isConnected in
            guard let self = self else {return}
            if !isConnected {
                self.hideLoadingView()
                self.refreshButton.isHidden = false
                self.networkWarningLabel.isHidden = false
            } else {
                self.getPlaces(search: "", location: "")
            }
        }
    }
    
    //Fetch place data when user searches something
    func getPlaces(search: String, location: String) {
        searchViewModel.fetchSearchedPlaces(search: search, location: location) {[weak self] error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.hideLoadingView()
                    self.showErrorAlert()
                }
                print("Error in getting searched places: \(error) ")
            } else {
                DispatchQueue.main.async {
                    //Hide loadingView
                    self.hideLoadingView()
                    //Update placesTableView
                    self.applySnapshot()
                    //Update mapView
                    self.createAnnotations(places: self.searchViewModel.searchedPlaces)
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Deselect selected annotations when after view appears
        let selectedAnnotations = mapView.selectedAnnotations
        for annotation in selectedAnnotations {
            mapView.deselectAnnotation(annotation, animated: true)
        }
    }
    deinit {
        //Remove all annotations when view controller denitializes
        let allAnotations = mapView.annotations
        mapView.removeAnnotations(allAnotations)
    }
}
