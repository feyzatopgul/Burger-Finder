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
    func configureSettingsButton() {
        settingsButton.backgroundColor = .tertiarySystemBackground
        settingsButton.setTitle(HomeViewConstants.settingsButtonTitle, for: .normal)
        settingsButton.setTitleColor(UIColor(named: HomeViewConstants.primaryAppColor), for: .normal)
        settingsButton.tintColor = .tertiarySystemBackground
        settingsButton.layer.cornerRadius = 10
        
        //Add target
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
        //Adjust constraints
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            settingsButton.centerXAnchor.constraint(equalTo: warningView.centerXAnchor),
            settingsButton.topAnchor.constraint(equalTo: locationWarningLabel.bottomAnchor, constant: 30),
            settingsButton.widthAnchor.constraint(equalToConstant: 150),
            settingsButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    //Open app settings 
    @objc func goToSettings() {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
