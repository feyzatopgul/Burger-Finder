//
//  HomeViewController+Spinner.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func configureSpinner() {
        spinnerView.isHidden = true
        spinnerView.style = .medium
        spinnerView.color = .tertiarySystemBackground
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            spinnerView.centerXAnchor.constraint(equalTo: warningView.centerXAnchor),
            spinnerView.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 30),
            spinnerView.widthAnchor.constraint(equalToConstant: 100),
            spinnerView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func showSpinner(){
        spinnerView.isHidden = false
        refreshButton.isHidden = true
        spinnerView.startAnimating()
    }
    
    func hideSpinner(){
        spinnerView.stopAnimating()
        refreshButton.isHidden = false
        spinnerView.isHidden = true
    }
    
   
}
