//
//  SearchViewController+PlacesTableView.swift
//  Burger Finder
//
//  Created by fyz on 12/25/22.
//

import Foundation
import UIKit

extension SearchViewController {
    //Configure placesTableView
    func configurePlacesTableView() {
        view.addSubview(placesTableView)
        //set delegate
        placesTableView.delegate = self
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
        
        //Dismiss keyboard when tableView is dragged
        placesTableView.keyboardDismissMode = .onDrag
        
        //Register a cell
        placesTableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
    }
    
    //Create data source for placesTableView
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
        
        //Set price for priceView
        placeCell.priceView.price = place.price
        
        //Set isOpenLabel
        placeCell.isOpenLabel.font = .systemFont(ofSize: 16, weight: .medium)
        if place.hours.openNow {
            placeCell.isOpenLabel.textColor = UIColor(named: SearchViewConstants.primaryAppColor)
            placeCell.isOpenLabel.text = SearchViewConstants.isOpenLabelOpen
        } else {
            placeCell.isOpenLabel.textColor = UIColor(named: SearchViewConstants.textColor)
            placeCell.isOpenLabel.text = SearchViewConstants.isOpenLabelClosed
        }

        //Set imageView with a placeholder
        placeCell.placeImage.image = UIImage(named: SearchViewConstants.burgerIcon)
    
        //Set imageView with the first photo if available
        if let photos = place.photos {
            if !photos.isEmpty {
                let photo = photos.first!
                searchViewModel.fetchImage(prefix: photo.prefix,
                                           suffix: photo.suffix,
                                           size: SearchViewConstants.imageSize) { result in
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
    //Apply snapshot for update placesTableView
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
