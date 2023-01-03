//
//  HomeViewController+WarningLabel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func configureWarningLabel() {
        
        warningLabel.text = HomeViewConstants.warningLabel
        warningLabel.textColor = UIColor(named: HomeViewConstants.warningLabelColor)
        warningLabel.numberOfLines = 0
        warningLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            warningLabel.leadingAnchor.constraint(equalTo: warningView.leadingAnchor, constant: 25),
            warningLabel.trailingAnchor.constraint(equalTo: warningView.trailingAnchor, constant: -25),
            warningLabel.topAnchor.constraint(equalTo: warningView.topAnchor, constant: 40),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
