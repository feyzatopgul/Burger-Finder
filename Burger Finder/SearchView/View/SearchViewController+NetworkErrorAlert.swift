//
//  SearchViewController+NetworkErrorAlert.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/10/23.
//

import Foundation
import UIKit

extension SearchViewController {
    //Show alert if there is an error in network call
    func showErrorAlert() {
        //Create alertView
        let alert = UIAlertController(title: SearchViewConstants.networkErrorAlertTitle,
                                      message: SearchViewConstants.networkErrorAlertMessage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
