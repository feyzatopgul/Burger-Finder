//
//  FavoritesViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoritePlaces = [Place]()
    var favoritesViewModel = FavoritesViewModel()
    
    let favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    typealias DataSource = UICollectionViewDiffableDataSource<FavoritesSection,Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, Place>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favorites"
        navigationItem.backButtonDisplayMode = .minimal
        
        view.addSubview(favoritesCollectionView)
        
        //configure favoritesCollectionView
        configureFavoritesCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoritePlaces = favoritesViewModel.getSavedPlaces()
        applySnapshot()
    }

}


