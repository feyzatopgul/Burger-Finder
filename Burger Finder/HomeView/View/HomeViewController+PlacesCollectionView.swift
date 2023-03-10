//
//  HomeViewController+PlacesCollectionView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    //Configure placesCollectionView
    func configurePlacesCollectionView() {
        placesCollectionView.addSubview(refreshButton)
        placesCollectionView.addSubview(spinnerView)
        placesCollectionView.addSubview(networkWarningLabel)
        
        placesCollectionView.backgroundColor = .clear
        placesCollectionView.delegate = self
        
        //Set scroll direction as horizontal
        if let layout = placesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 10
        }
        
        //Adjust constraints
        placesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            placesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2),
            placesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 9),
            placesCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width - 10)
        ]
        NSLayoutConstraint.activate(constraints)
        
        //Register a cell
        placesCollectionView.register(PopularPlaceCell.self, forCellWithReuseIdentifier: HomeViewConstants.popularPlaceCellIdentifier)
    }

    
    //Create data source for collectionView
    func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: placesCollectionView) {[weak self] collectionView, indexPath, place in
            guard let self = self,
                  let popularPlaceCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeViewConstants.popularPlaceCellIdentifier,
                    for: indexPath) as? PopularPlaceCell else { return UICollectionViewCell() }
            
            self.populateCell(popularPlaceCell: popularPlaceCell, place: place)
           
            return popularPlaceCell
        }
        return dataSource
    }
    
    //Populate popularPlaceCell with data
    func populateCell(popularPlaceCell: PopularPlaceCell, place: Place) {
        //Set nameLabel
        popularPlaceCell.nameLabel.text = place.name
        
        //Set rating for ratingView
        popularPlaceCell.ratingView.rating = place.rating
        
        //Set imageView with a placeholder
        popularPlaceCell.imageView.image = UIImage(named: HomeViewConstants.placeHolderBurger)
        //Set imageView with the first photo if available
        if let photos = place.photos {
            if !photos.isEmpty {
                let photo = photos.first!
                homeViewModel.fetchImage(prefix: photo.prefix,
                                         suffix: photo.suffix,
                                         size: HomeViewConstants.imageSize ) { result in
                    switch result {
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            popularPlaceCell.imageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
    
    //Apply snapshot for update collectionView
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(homeViewModel.popularPlaces)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

enum PopularPlacesSection {
    case main
}
