//
//  HomeViewController+RefreshButton.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    //Configure refreshButton
    func configureRefreshButton() {
        refreshButton.backgroundColor = .tertiarySystemBackground
        refreshButton.setTitle(HomeViewConstants.refreshButtonTitle, for: .normal)
        refreshButton.setTitleColor(UIColor(named: HomeViewConstants.primaryAppColor), for: .normal)
        refreshButton.tintColor = .tertiarySystemBackground
        refreshButton.layer.cornerRadius = 10
        
        //Add target
        refreshButton.addTarget(self, action: #selector(refreshWarningView), for: .touchUpInside)
        
        //Adjust constraints
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            refreshButton.centerXAnchor.constraint(equalTo: warningView.centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 30),
            refreshButton.widthAnchor.constraint(equalToConstant: 100),
            refreshButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    //Refresh view when refreshButton is tapped
    @objc func refreshWarningView() {
        showSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.hideSpinner()
            self.checkLocationEnabled()

        }
        
    }
    
}
