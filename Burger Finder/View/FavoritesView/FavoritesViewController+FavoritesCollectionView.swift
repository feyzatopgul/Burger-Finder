//
//  FavoritesViewController+FavoritesCollectionView.swift
//  Burger Finder
//
//  Created by fyz on 12/28/22.
//

import Foundation
import UIKit

extension FavoritesViewController {
    
    func configureFavoritesCollectionView(){
        favoritesCollectionView.backgroundColor = .tertiarySystemBackground
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = dataSource
        
        //Set scroll direction as vertical
        if let layout = favoritesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 10
        }
        
        //Adjust constraints
        favoritesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        let constraints = [
            favoritesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesCollectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            favoritesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        //Register a cell
        favoritesCollectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: FavoritesCell.identifier)
    }
    
    //Create data source for collectionView
    func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: favoritesCollectionView) { collectionView, indexPath, place in
            guard let favoritesCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.identifier, for: indexPath) as? FavoritesCell else { return UICollectionViewCell()}
            
            favoritesCell.nameLabel.text = place.name
            favoritesCell.locationLabel.text = place.location?.locality
            favoritesCell.ratingView.rating = place.rating
            return favoritesCell
        }
        return dataSource
    }
    
    //Apply snapshot for update collectionView
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(favoritePlaces)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
enum FavoritesSection {
    case main
}
