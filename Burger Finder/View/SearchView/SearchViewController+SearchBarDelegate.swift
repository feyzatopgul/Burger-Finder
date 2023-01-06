//
//  SearchViewController+SearchBarDelegate.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/25/22.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    //Get places data when a place or a location text is entered
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == placeSearchBar {
            if let text = placeSearchBar.text {
                searchViewModel.placeText = text
            }
        }
        if searchBar == locationSearchBar {
            if let text = locationSearchBar.text {
                searchViewModel.locationText = text
            }
        }
        
        //Wait for the user to type some text to prevent making too much network calls
        if !searchViewModel.placeText.isEmpty || !searchViewModel.locationText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                self.getPlaces(search: self.searchViewModel.placeText, location: self.searchViewModel.locationText)
            }
        } else {
            getPlaces(search: self.searchViewModel.placeText, location: self.searchViewModel.locationText)
        }
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
