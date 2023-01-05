//
//  HomeViewController+CollectionViewDelegates.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/26/22.
//

import Foundation
import UIKit

extension HomeViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    // Adjust item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: placesCollectionView.frame.width/2, height: placesCollectionView.frame.height)
    }
    //Navigate to DetailsViewController when a placesCollectionView cell is tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.detailsViewModel.place = homeViewModel.popularPlaces[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
