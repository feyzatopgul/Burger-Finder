//
//  HomeViewController+RefreshButton.swift
//  Burger Finder
//
//  Created by fyz on 1/6/23.
//

import Foundation

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
        refreshButton.isHidden = true
        
        //Add target
        refreshButton.addTarget(self, action: #selector(refreshPopularPlacesView), for: .touchUpInside)
        
        //Adjust constraints
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            refreshButton.centerXAnchor.constraint(equalTo: placesCollectionView.centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: placesCollectionView.bottomAnchor, constant: 30),
            refreshButton.widthAnchor.constraint(equalToConstant: 100),
            refreshButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    //Refresh view when refreshButton is tapped
    @objc func refreshPopularPlacesView() {
        showSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.hideSpinner()
            if NetworkReachability.shared.isConnectedToNetwork(){
                self.refreshButton.isHidden = true
                self.checkLocationEnabled()
            }
        }
        
    }
}

