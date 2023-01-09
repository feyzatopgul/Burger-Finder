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
        //If search bar texts are empty immediately get places from API, else wait for user types some text in order to prevent making too much requests
        if searchViewModel.placeText.isEmpty && searchViewModel.locationText.isEmpty {
            getPlaces(search: "", location: "")
        } else {
            //Cancel currently pending items
            pendingRequestWorkItem?.cancel()

            // Replace previous workitem with a new one
            let requestWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                self.getPlaces(search: self.searchViewModel.placeText, location: self.searchViewModel.locationText)
            }
            pendingRequestWorkItem = requestWorkItem
            // Execute request in 0.5 seconds
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: requestWorkItem)
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
