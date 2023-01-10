//
//  SearchViewController+RefreshButton.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/7/23.
//

import Foundation
import UIKit

extension SearchViewController {
    
    //Configure refreshButton
    func configureRefreshButton() {
        refreshButton.backgroundColor = UIColor(named: SearchViewConstants.primaryAppColor)
        refreshButton.setTitle(HomeViewConstants.refreshButtonTitle, for: .normal)
        refreshButton.setTitleColor(.tertiarySystemBackground, for: .normal)
        refreshButton.tintColor = UIColor(named: SearchViewConstants.primaryAppColor)
        refreshButton.layer.cornerRadius = 10
        refreshButton.isHidden = true
        
        //Add target
        refreshButton.addTarget(self, action: #selector(refreshSearchView), for: .touchUpInside)
        
        //Adjust constraints
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            refreshButton.centerXAnchor.constraint(equalTo: placesTableView.centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: networkWarningLabel.bottomAnchor, constant: 20),
            refreshButton.widthAnchor.constraint(equalToConstant: 100),
            refreshButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    //Refresh view when refreshButton is tapped
    @objc func refreshSearchView() {
        showSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.hideSpinner()
            if NetworkReachability.shared.isConnectedToNetwork(){
                self.refreshButton.isHidden = true
                self.networkWarningLabel.isHidden = true
                self.configureAndShowLoadingView()
                self.getPlaces(search: "", location: "")
            }
        }
    }
}
