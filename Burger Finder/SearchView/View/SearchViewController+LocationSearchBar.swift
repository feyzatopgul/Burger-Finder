//
//  SearchViewController+LocationSearchBar.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/25/22.
//

import Foundation
import UIKit

extension SearchViewController {
    //Configure locationSearchBar
    func configureLocationSearchBar() {
        view.addSubview(locationSearchBar)
        let guide = view.safeAreaLayoutGuide
        locationSearchBar.delegate = self
        locationSearchBar.placeholder = SearchViewConstants.locationSearchBarPlaceholder
        locationSearchBar.setImage(UIImage(systemName: SearchViewConstants.locationImage), for: .search, state: .normal)
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        //Adjust constraints
        let constraints = [
            locationSearchBar.topAnchor.constraint(equalTo: guide.topAnchor),
            locationSearchBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 45),
            locationSearchBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -55)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
