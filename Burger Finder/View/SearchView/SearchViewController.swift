//
//  SearchViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {

    var downloadViewModel = DownloadViewModel()
    
    let placeSearchController = UISearchController()
    let locationSearchBar = UISearchBar()
    
    private var location: String = ""
    private var searchTerm: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.searchController = placeSearchController
        navigationItem.hidesBackButton = true
        placeSearchController.searchBar.showsCancelButton = false
        placeSearchController.searchResultsUpdater = self
        
        view.addSubview(locationSearchBar)
        locationSearchBar.delegate = self
        locationSearchBar.placeholder = "Current location..."
        locationSearchBar.setImage(UIImage(systemName: "location"), for: .search, state: .normal)

        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        let guide = self.view.safeAreaLayoutGuide
        let constraints = [
            locationSearchBar.topAnchor.constraint(equalTo: guide.topAnchor),
            locationSearchBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            locationSearchBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        location = searchText
        LocationManager.shared.findLocation(query: location) { result in
            if let result = result {
                print("valid location: \(result)")
            } else {
                print("Location is not valid")
            }
        }
//        downloadViewModel.fetchSearchedPlaces(search: "", location: searchText) { result in
//            switch result {
//            case .success(let returnedPlaces):
//                print(returnedPlaces)
//            case.failure(let error):
//                print(error)
//            }
//        }

    }
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        searchTerm = text
        print(searchTerm)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
