//
//  HomeViewController+WarningLabel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    //Configure warningLabel
    func configureLocationWarningLabel() {
        locationWarningLabel.text = HomeViewConstants.locationWarningLabel
        locationWarningLabel.textColor = UIColor(named: HomeViewConstants.warningLabelColor)
        locationWarningLabel.numberOfLines = 0
        locationWarningLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        //Adjust constraints
        locationWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            locationWarningLabel.leadingAnchor.constraint(equalTo: warningView.leadingAnchor, constant: 25),
            locationWarningLabel.trailingAnchor.constraint(equalTo: warningView.trailingAnchor, constant: -25),
            locationWarningLabel.topAnchor.constraint(equalTo: warningView.topAnchor, constant: 40),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
