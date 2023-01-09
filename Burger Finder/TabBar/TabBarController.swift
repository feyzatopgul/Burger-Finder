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
        homeVC.tabBarItem = UITabBarItem(title: TabBarConstants.homeTitle,
                                         image: UIImage(systemName: TabBarConstants.houseImage), tag: 0)
        
        let favVC = UINavigationController(rootViewController: FavoritesViewController())
        favVC.tabBarItem = UITabBarItem(title: TabBarConstants.favoritesTitle,
                                        image: UIImage(systemName: TabBarConstants.heartImage), tag: 1)
        
        self.setViewControllers([homeVC, favVC], animated: true)
        
        self.tabBar.tintColor = UIColor(named: TabBarConstants.primaryAppColor)
        self.tabBar.backgroundColor = .tertiarySystemBackground
    }

}
