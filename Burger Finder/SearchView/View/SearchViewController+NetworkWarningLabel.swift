//
//  SearchViewController+NetworkWarningLabel.swift
//  Burger Finder
//
//  Created by fyz on 1/7/23.
//

import Foundation
import UIKit

extension SearchViewController {
    //Configure networkWarningLabel
    func configureNetworkWarningLabel() {
        
        networkWarningLabel.isHidden = true
        networkWarningLabel.numberOfLines = 0
        networkWarningLabel.text = SearchViewConstants.networkWarningLabel
        networkWarningLabel.textColor = UIColor(named: SearchViewConstants.textColor)
        
        //Adjust constraints
        networkWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            networkWarningLabel.topAnchor.constraint(equalTo: placesTableView.topAnchor, constant: 30),
            networkWarningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            networkWarningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
