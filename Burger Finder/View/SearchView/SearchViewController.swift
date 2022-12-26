//
//  SearchViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class SearchViewController: UIViewController {

    var downloadViewModel = DownloadViewModel()
    var imageLoadViewModel = ImageLoadViewModel()
    var places = [Place]()
    
    let placeSearchBar = UISearchBar()
    let locationSearchBar = UISearchBar()
    var placeText = ""
    var locationText = ""
    
    let placesTableView = UITableView()
    typealias DataSource = UITableViewDiffableDataSource<PlacesSection, Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PlacesSection, Place>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        //Configure placeSearchBar
        configurePlaceSearchBar()
        
        //Configure locationSearchBar
        configureLocationSearchBar()
        
        //Configure placesTableView
        configurePlacesTableView()
        
        getPlaces(search: "", location: "")
        
        //Update placesTableView
        applySnapshot()
        
        //Dismiss keyboard when anywhere is tapped
        dismissKeyboardWhenViewIsTapped()
    }
    
    //Fetch place data when user search something
    func getPlaces(search: String, location: String) {
        downloadViewModel.fetchSearchedPlaces(search: search, location: location) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let returnedPlaces):
                self.places = returnedPlaces
                DispatchQueue.main.async {
                    self.applySnapshot()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
