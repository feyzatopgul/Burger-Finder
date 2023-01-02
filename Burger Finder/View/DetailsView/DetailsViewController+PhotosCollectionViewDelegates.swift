//
//  DetailsViewController+PhotosCollectionViewDelegates.swift
//  Burger Finder
//
//  Created by fyz on 1/1/23.
//

import Foundation
import UIKit

extension DetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    // Adjust item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photosCollectionView.frame.width/2, height: photosCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoViewController()
        photoVC.photo = photos[indexPath.row]
        photoVC.modalPresentationStyle = .fullScreen
        photoVC.modalTransitionStyle = .crossDissolve
        self.present(photoVC, animated: true)
    }
}
