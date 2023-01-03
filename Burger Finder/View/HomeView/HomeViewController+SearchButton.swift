//
//  HomeViewController+SearchField.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    //Configure searchButton
    func configureSearchButton() {
        self.view.addSubview(searchButton)
        //Button configuration
        searchButton.backgroundColor = .tertiarySystemBackground
        searchButton.setTitle(HomeViewConstants.searchBarTitle, for: .normal)
        searchButton.setTitleColor(.systemGray2, for: .normal)
        searchButton.tintColor = .systemGray2
        searchButton.layer.cornerRadius = 10
        searchButton.contentHorizontalAlignment = .leading
        
        //Add target
        searchButton.addTarget(self, action: #selector(showSearchView), for: .touchUpInside)
        
        //Adjust constraints
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 3),
            searchButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Navigate to SearchViewController when searchButton is tapped
    @objc func showSearchView() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }

}
