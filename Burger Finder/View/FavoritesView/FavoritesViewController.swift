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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesSearchBar.text = ""
        //Is it OK to put it on viewWillAppear
        favoritePlaces = favoritesViewModel.getSavedPlaces()
        applySnapshot()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        favoritePlaces = favoritesViewModel.getSavedPlaces()
//        applySnapshot()
    }

}


