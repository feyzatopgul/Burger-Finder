//
//  FavoritesViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoritesViewModel = FavoritesViewModel()
    
    let favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    typealias DataSource = UICollectionViewDiffableDataSource<FavoritesSection,Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, Place>
    lazy var dataSource = createDataSource()
    
    let favoritesSearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = FavoritesViewConstants.title
        navigationItem.backButtonDisplayMode = .minimal
        
        view.addSubview(favoritesCollectionView)
        view.addSubview(favoritesSearchBar)
        
        //configure favoritesCollectionView
        configureFavoritesCollectionView()
        
        //configure favoritesSearchBar
        configureFavoritesSearchBar()

        //Dismiss keyboard when anywhere is tapped on screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesSearchBar.text = ""
        favoritesViewModel.getSavedPlaces()
        applySnapshot()
    }
}


