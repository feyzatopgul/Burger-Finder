//
//  SearchViewController+MapButton.swift
//  Burger Finder
//
//  Created by fyz on 12/30/22.
//

import Foundation
import UIKit

extension SearchViewController {
    func configureMapButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "mapIcon"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showMapView))
    }
    @objc func showMapView() {
        let mapVC = MapViewController()
        mapVC.modalPresentationStyle = .fullScreen
        mapVC.modalTransitionStyle = .flipHorizontal
        self.present(mapVC, animated: true)
    }
}
