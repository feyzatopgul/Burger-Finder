//
//  HomeViewController+ShowNetworkAlert.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/5/23.
//

import Foundation
import UIKit

extension HomeViewController {
    
    //Show alert if network is not connected
    func showNetworkAlert() {
        //Create alertView
        let alert = UIAlertController(title: HomeViewConstants.alertTitle ,
                                      message: HomeViewConstants.alertMessage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
