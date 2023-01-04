//
//  DetailsViewController+PhotosCollectionView.swift
//  Burger Finder
//
//  Created by fyz on 12/27/22.
//

import Foundation
import UIKit

extension DetailsViewController {
    //Configure photosCollectionView
    func configurePhotosCollectionView() {
        photosCollectionView.backgroundColor = .clear
        photosCollectionView.delegate = self
        
        //Set scroll direction as horizontal
        if let layout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 10
        }
        
        //Adjust constraints
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        let constraints = [
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            photosCollectionView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
            photosCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            photosCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ]
        NSLayoutConstraint.activate(constraints)
        
        //Register a cell
        photosCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
    }
    
    //Create data source for photosCollectionView
    func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: photosCollectionView) {[weak self] collectionView, indexPath, placePhoto in
            guard let self = self,
                  let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
            self.populateCell(photoCell: photoCell, photo: placePhoto)
            
            return photoCell
        }
        return dataSource
    }
    
    //Populate photoCell with data
    func populateCell(photoCell: PhotoCell, photo: Photo) {
        //Set imageView with a placeholder
        photoCell.placeImageView.image = UIImage(named: DetailsViewConstants.burgerIcon)
        //Set imageView with place photos
        detailsViewModel.fetchImage(prefix: photo.prefix,
                                    suffix: photo.suffix,
                                    size: DetailsViewConstants.imageSize) { result in
            switch result {
            case .failure(let error):
                print("Error loading image: \(error)")
            case .success(let imageData):
                DispatchQueue.main.async {
                    photoCell.placeImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    //Apply snapshot for update photosCollectionView
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

enum PhotosSection {
    case main
}
