//
//  HomeViewController+WarningView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    //Configure warningView
    func configureWarningView() {
        view.addSubview(warningView)
        warningView.addSubview(warningLabel)
        warningView.addSubview(settingsButton)
        
        //Set warningView hidden by default
        warningView.isHidden = true
        
        //Configure warningView
        warningView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            warningView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 5 / 12),
            warningView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            warningView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
