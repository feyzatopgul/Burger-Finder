//
//  SearchViewController+PlacesTableView.swift
//  Burger Finder
//
//  Created by fyz on 12/25/22.
//

import Foundation
import UIKit

extension SearchViewController {
    
    func configurePlacesTableView() {
        view.addSubview(placesTableView)
        //placesTableView.backgroundColor = .blue
        
        //Set row height
        placesTableView.rowHeight = 150
        
        //Adjust constraints
        placesTableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            placesTableView.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor),
            placesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            placesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            placesTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        //Register a cell
        placesTableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
        
    }
    
    //Create data source for tableView
    func createDataSource() -> DataSource {
        let dataSource = DataSource(tableView: placesTableView) { [weak self] tableView, indexPath, place in
            guard let self = self,
                  let placeCell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.identifier, for: indexPath) as? PlaceCell else {
                      return UITableViewCell()
                  }
            self.populateCell(placeCell: placeCell, place: place)
            return placeCell
        }
        return dataSource
    }
    func populateCell(placeCell: PlaceCell, place: Place){
        //Set nameLabel
        placeCell.nameLabel.text = place.name
        //Set ratingLabel
        if let rating = place.rating {
            placeCell.ratingLabel.text = "\(rating)"
        } else {
            placeCell.ratingLabel.text = "0.0"
        }

        //Set imageView with a placeholder
        placeCell.placeImage.image = UIImage(named: "placeholderBurger")
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
                            placeCell.placeImage.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
        
    }
    //Apply snapshot for update tableView
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(places)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

enum PlacesSection {
    case main
}
