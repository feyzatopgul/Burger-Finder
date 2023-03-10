//
//  DetailsViewController+DetailInfoView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/27/22.
//

import Foundation
import UIKit

extension DetailsViewController {
    
    //Configure detailInfoView
    func configureDetailInfoView(){
        detailInfoView.place = detailsViewModel.place
        
        //Adjust constraints
        detailInfoView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            detailInfoView.centerXAnchor.constraint(equalTo: detailsScrollView.centerXAnchor),
            detailInfoView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 30),
            detailInfoView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
