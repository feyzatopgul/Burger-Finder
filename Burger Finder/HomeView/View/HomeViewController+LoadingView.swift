//
//  HomeViewController+LoadingView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/5/23.
//

import Foundation
import UIKit

extension HomeViewController {
    
    //Configure loadingView
    func configureAndShowLoadingView() {
        
        let indicator = UIActivityIndicatorView()
        placesCollectionView.addSubview(indicator)
        
        //Adjust constraints
        indicator.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            indicator.centerXAnchor.constraint(equalTo: placesCollectionView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: placesCollectionView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        indicator.style = .large
        indicator.color = .white
        indicator.tag = 100
        indicator.startAnimating()
    }
    
    func hideLoadingView() {
        let indicator = placesCollectionView.viewWithTag(100) as? UIActivityIndicatorView
        indicator?.stopAnimating()
        indicator?.removeFromSuperview()
    }
}
