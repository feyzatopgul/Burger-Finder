//
//  HomeViewController+PopularPlacesLabel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    //Configure popularPlacesLabel
    func configurePopularPlacesLabel() {
        popularPlacesLabel.text = HomeViewConstants.popularPlacesLabel
        popularPlacesLabel.textColor = UIColor(named: HomeViewConstants.textColor)
        popularPlacesLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        //Adjust constraints
        popularPlacesLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            popularPlacesLabel.leadingAnchor.constraint(equalTo: popularPlacesView.leadingAnchor, constant: 10),
            popularPlacesLabel.trailingAnchor.constraint(equalTo: popularPlacesView.trailingAnchor),
            popularPlacesLabel.topAnchor.constraint(equalTo: popularPlacesView.topAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
