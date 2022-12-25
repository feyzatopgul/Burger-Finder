//
//  HomeViewController+NearbyPlacesView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation
import UIKit

extension HomeViewController:UICollectionViewDelegateFlowLayout {
    
//MARK: - CollectionView Layouts
    
    func configurePlacesCollectionView() {
        //popularPlacesView.addSubview(placesCollectionView)
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
            //placesCollectionView.topAnchor.constraint(equalTo: popularPlacesLabel.bottomAnchor),
            placesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2),
            placesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 8),
            placesCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ]
        NSLayoutConstraint.activate(constraints)
        
        //Register a cell
        placesCollectionView.register(PopularPlaceCell.self, forCellWithReuseIdentifier: PopularPlaceCell.identifier)
    }
    
    // Adjust item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: placesCollectionView.frame.width/2, height: placesCollectionView.frame.height)
    }

//MARK: - Data Source and Snapshot
    //Create data source
    func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: placesCollectionView) {[weak self] collectionView, indexPath, place in
            guard let self = self,
                  let popularPlaceCell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularPlaceCell.identifier, for: indexPath) as? PopularPlaceCell else { return UICollectionViewCell() }
            
            self.populateCell(popularPlaceCell: popularPlaceCell, place: place)
           
            return popularPlaceCell
        }
        return dataSource
    }
    
    //Populate popularPlaceCell with data
    func populateCell(popularPlaceCell: PopularPlaceCell, place: Place) {
        //Set nameLabel
        popularPlaceCell.nameLabel.text = place.name
        //Set ratingLabel
        if let rating = place.rating {
            popularPlaceCell.ratingLabel.text = "\(rating)"
        } else {
            popularPlaceCell.ratingLabel.text = "0.0"
        }
        //Set imageView with a placeholder
        popularPlaceCell.imageView.image = UIImage(named: "placeholderBurger")
        if let photos = place.photos {
            if !photos.isEmpty {
                let photo = photos.first!
                imageLoadViewModel.fetchImage(prefix: photo.prefix,
                                              suffix: photo.suffix) { result in
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
    
    //Apply snapshot for update
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(places)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

enum PopularPlacesSection {
    case main
}
