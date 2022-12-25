//
//  HomeViewController+PopularPlacesLabel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func configurePopularPlacesLabel() {
        
        popularPlacesLabel.text = "Popular burger places around you..."
        popularPlacesLabel.textColor = .tertiarySystemBackground
        popularPlacesLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        
        popularPlacesLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            popularPlacesLabel.leadingAnchor.constraint(equalTo: popularPlacesView.leadingAnchor, constant: 10),
            popularPlacesLabel.trailingAnchor.constraint(equalTo: popularPlacesView.trailingAnchor),
            popularPlacesLabel.topAnchor.constraint(equalTo: popularPlacesView.topAnchor),
            popularPlacesLabel.bottomAnchor.constraint(equalTo: placesCollectionView.topAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
