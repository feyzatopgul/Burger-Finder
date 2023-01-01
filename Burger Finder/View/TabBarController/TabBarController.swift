//
//  TabBarController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let favVC = UINavigationController(rootViewController: FavoritesViewController())
        favVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        
        self.setViewControllers([homeVC, favVC], animated: true)
        
        self.tabBar.tintColor = UIColor(named: "primaryAppColor")
        self.tabBar.backgroundColor = .tertiarySystemBackground
    }

}
