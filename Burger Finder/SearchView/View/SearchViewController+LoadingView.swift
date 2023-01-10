//
//  SearchViewController+LoadingView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/5/23.
//

import Foundation
import UIKit

extension SearchViewController {
    
    //Configure loadingView
    func configureAndShowLoadingView() {
        
        let indicator = UIActivityIndicatorView()
        placesTableView.addSubview(indicator)
        
        //Adjust constraints
        indicator.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            indicator.centerXAnchor.constraint(equalTo: placesTableView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: placesTableView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        indicator.style = .large
        indicator.tag = 200
        indicator.startAnimating()
    }
    
    func hideLoadingView() {
        let indicator = placesTableView.viewWithTag(200) as? UIActivityIndicatorView
        indicator?.stopAnimating()
        indicator?.removeFromSuperview()
    }
}
