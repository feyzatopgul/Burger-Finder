//
//  FavoritesViewController+CollectionViewDelegates.swift
//  Burger Finder
//
//  Created by fyz on 12/28/22.
//

import Foundation
import UIKit

extension FavoritesViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    // Adjust item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: favoritesCollectionView.frame.width/2 - 25, height: favoritesCollectionView.frame.width/2 - 25)
    }
    //Add spacing around collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    //Navigate to DetailsViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.place = favoritePlaces[indexPath.row]
        detailsVC.saveButtonTapped = true
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
