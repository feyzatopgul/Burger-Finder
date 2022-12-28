//
//  DetailsViewController+DetailsScrollView.swift
//  Burger Finder
//
//  Created by fyz on 12/27/22.
//

import Foundation
import UIKit

extension DetailsViewController {
    
    //Configures detailsScrollView that has a contents of detailInfoView and getDirectionsButton
    func configureDetailsScrollView() {
        detailsScrollView.addSubview(detailInfoView)
        detailsScrollView.addSubview(getDirectionsButton)
        detailsScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 0.6)
        detailsScrollView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            detailsScrollView.topAnchor.constraint(equalTo: photosCollectionView.bottomAnchor),
            detailsScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
