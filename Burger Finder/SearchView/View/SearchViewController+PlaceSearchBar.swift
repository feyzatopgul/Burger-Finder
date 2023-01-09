//
//  SearchViewController+PlaceSearchBar.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/25/22.
//

import Foundation
import UIKit

extension SearchViewController {
    //Configure placesSearchBar
    func configurePlaceSearchBar() {
        view.addSubview(placeSearchBar)
        placeSearchBar.delegate = self
        placeSearchBar.sizeToFit()
        navigationItem.titleView = placeSearchBar
        placeSearchBar.placeholder = SearchViewConstants.placeSearchBarPlaceholder
    }
    
}
