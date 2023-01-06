//
//  DetailsViewController+LoadingView.swift
//  Burger Finder
//
//  Created by fyz on 1/5/23.
//

import Foundation
import UIKit

extension DetailsViewController {
    //Configure loadingView
    func configureAndShowLoadingView() {
        
        let indicator = UIActivityIndicatorView()
        photosCollectionView.addSubview(indicator)
        
        //Adjust constraints
        indicator.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            indicator.centerXAnchor.constraint(equalTo: photosCollectionView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: photosCollectionView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        indicator.style = .large
        indicator.tag = 300
        indicator.startAnimating()
    }
    
    func hideLoadingView() {
        let indicator = photosCollectionView.viewWithTag(300) as? UIActivityIndicatorView
        indicator?.stopAnimating()
        indicator?.removeFromSuperview()
    }
}
    
