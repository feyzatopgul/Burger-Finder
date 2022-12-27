//
//  SearchViewController+PlaceSearchBar.swift
//  Burger Finder
//
//  Created by fyz on 12/25/22.
//

import Foundation
import UIKit

extension SearchViewController {
    
    func configurePlaceSearchBar() {
        view.addSubview(placeSearchBar)
        let guide = self.view.safeAreaLayoutGuide
        placeSearchBar.delegate = self
//        placeSearchBar.sizeToFit()
//        navigationItem.titleView = placeSearchBar
        placeSearchBar.placeholder = "Search for a place..."
        placeSearchBar.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            placeSearchBar.topAnchor.constraint(equalTo: guide.topAnchor),
            placeSearchBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            placeSearchBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}