//
//  HomeViewController+WarningView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func configureWarningView() {
        view.addSubview(warningView)
        warningView.addSubview(warningLabel)
        warningView.addSubview(refreshButton)
        warningView.addSubview(spinnerView)
        
        warningView.isHidden = true

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
