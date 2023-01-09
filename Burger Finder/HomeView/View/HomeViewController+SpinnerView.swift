//
//  HomeViewController+SpinnerView.swift
//  Burger Finder
//
//  Created by fyz on 1/6/23.
//

import Foundation
import UIKit

extension HomeViewController {
    //Configure spinnerView
    func configureSpinner() {
        
        spinnerView.isHidden = true
        spinnerView.style = .medium
        spinnerView.color = .tertiarySystemBackground
        
        //Adjust constraints
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            spinnerView.centerXAnchor.constraint(equalTo: popularPlacesView.centerXAnchor),
            spinnerView.topAnchor.constraint(equalTo: networkWarningLabel.bottomAnchor, constant: 30),
            spinnerView.widthAnchor.constraint(equalToConstant: 100),
            spinnerView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Show spinnerView
    func showSpinner(){
        spinnerView.isHidden = false
        refreshButton.isHidden = true
        spinnerView.startAnimating()
    }
    
    //Hide spinnerView
    func hideSpinner(){
        spinnerView.stopAnimating()
        refreshButton.isHidden = false
        spinnerView.isHidden = true
    }
}
