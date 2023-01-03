//
//  DetailsViewController+NavigationTitle.swift
//  Burger Finder
//
//  Created by fyz on 1/2/23.
//

import Foundation
import UIKit

extension DetailsViewController {
    
    //Configure navigation title to make multiline title
    func configureNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor(named: "textColor")
        titleLabel.textAlignment = .center
        titleLabel.text = place?.name
        navigationItem.titleView = titleLabel
    }
}
