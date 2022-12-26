//
//  SearchViewController+LocationSearchBar.swift
//  Burger Finder
//
//  Created by fyz on 12/25/22.
//

import Foundation
import UIKit

extension SearchViewController {
    
    func configureLocationSearchBar() {
        view.addSubview(locationSearchBar)
        let guide = self.view.safeAreaLayoutGuide
        locationSearchBar.delegate = self
        locationSearchBar.placeholder = "Current location..."
        locationSearchBar.setImage(UIImage(systemName: "location"), for: .search, state: .normal)
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            locationSearchBar.topAnchor.constraint(equalTo: placeSearchBar.bottomAnchor),
            locationSearchBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            locationSearchBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
