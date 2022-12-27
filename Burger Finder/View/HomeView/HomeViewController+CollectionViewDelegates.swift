//
//  HomeViewController+CollectionViewDelegates.swift
//  Burger Finder
//
//  Created by fyz on 12/26/22.
//

import Foundation
import UIKit

extension HomeViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    // Adjust item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: placesCollectionView.frame.width/2, height: placesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.place = places[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
