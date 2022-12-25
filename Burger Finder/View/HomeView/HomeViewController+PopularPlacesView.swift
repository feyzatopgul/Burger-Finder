//
//  HomeViewController+PopularPlacesView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func configurePopularPlacesView() {
        view.addSubview(popularPlacesView)
        popularPlacesView.addSubview(placesCollectionView)
        popularPlacesView.addSubview(popularPlacesLabel)
        popularPlacesView.isHidden = true
        
        popularPlacesView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            popularPlacesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popularPlacesView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 5 / 12),
            popularPlacesView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            popularPlacesView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
}
