//
//  SearchViewController+SearchBarDelegate.swift
//  Burger Finder
//
//  Created by fyz on 12/25/22.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    //Get places data when a place or a location text is entered
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == placeSearchBar {
            if let text = placeSearchBar.text {
                placeText = text
            }
        }
        if searchBar == locationSearchBar {
            if let text = locationSearchBar.text {
                locationText = text
            }
        }
        // ???
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) { [weak self] in
//            guard let self = self else { return }
//            self.getPlaces(search: self.placeText, location: self.locationText)
//            self.createAnnotations(places: self.places)
//        }
        print("Search: \(placeText)")
        print("Location: \(locationText)")
        getPlaces(search: placeText, location: locationText)
    }
    
    //Reset search bar text when cancel button is clicked to update the tableview
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        if searchBar == placeSearchBar {
            placeSearchBar.text = ""
        }
        if searchBar == locationSearchBar {
            locationSearchBar.text = ""
        }
    }
    
    //Dismiss keyboard when editing is done
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
