//
//  FavoritesViewController+SearchBar.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/1/23.
//

import Foundation
import UIKit

extension FavoritesViewController: UISearchBarDelegate {
    
    //Configure favoritesSearchBar
    func  configureFavoritesSearchBar() {
        let guide = view.safeAreaLayoutGuide
        favoritesSearchBar.delegate = self
        favoritesSearchBar.placeholder = FavoritesViewConstants.favoritesSearchBarPlaceholder
        
        //Adjust constraints
        favoritesSearchBar.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            favoritesSearchBar.topAnchor.constraint(equalTo: guide.topAnchor),
            favoritesSearchBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 25),
            favoritesSearchBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -25)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            //Filter saved places from CoreData if searchBar text is not empty
            favoritesViewModel.getFilteredPlaces(searchTerm: searchText)
        } else {
            //Get all saved places if searchBar text is empty
            favoritesViewModel.getSavedPlaces()
        }
        applySnapshot()
        
    }
    
    //Reset search bar text when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    //Dismiss keyboard when editing is done
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
