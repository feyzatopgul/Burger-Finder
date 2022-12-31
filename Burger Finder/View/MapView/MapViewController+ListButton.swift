//
//  MapViewController+ListButton.swift
//  Burger Finder
//
//  Created by fyz on 12/30/22.
//

import Foundation
import UIKit

extension MapViewController {
    
    func configureListButton(){
        
        view.addSubview(listButton)
        listButton.setImage(UIImage(named: "listIcon"), for: .normal)
        let guide = view.safeAreaLayoutGuide
        
        listButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            listButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
            listButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -25)
        ]
        NSLayoutConstraint.activate(constraints)
        
        listButton.addTarget(self, action: #selector(showSearchView), for: .touchUpInside)
    }
    
    @objc func showSearchView() {
        self.dismiss(animated: true)
    }
}
