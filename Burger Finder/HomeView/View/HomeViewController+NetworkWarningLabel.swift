//
//  HomeViewController+NetworkWarningLabel.swift
//  Burger Finder
//
//  Created by fyz on 1/9/23.
//

import Foundation
import UIKit

extension HomeViewController {
    //Configure networkWarningLabel
    func configureNetworkWarningLabel() {
        
        networkWarningLabel.isHidden = true
        networkWarningLabel.numberOfLines = 0
        networkWarningLabel.text = HomeViewConstants.networkWarningLabel
        networkWarningLabel.font =  UIFont.systemFont(ofSize: 18, weight: .semibold)
        networkWarningLabel.textColor = UIColor(named: HomeViewConstants.warningLabelColor)
        
        //Adjust constraints
        networkWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            networkWarningLabel.topAnchor.constraint(equalTo: placesCollectionView.topAnchor),
            networkWarningLabel.leadingAnchor.constraint(equalTo: popularPlacesView.leadingAnchor, constant: 20),
            networkWarningLabel.trailingAnchor.constraint(equalTo: popularPlacesView.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
