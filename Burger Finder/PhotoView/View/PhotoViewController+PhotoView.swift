//
//  PhotoViewController+PhotoView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/1/23.
//

import Foundation
import UIKit

extension PhotoViewController {
    
    //Configure photoView
    func configurePhotoView() {
        view.addSubview(photoView)
        photoView.layer.cornerRadius = 20
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        
        guard let photo = photoViewModel.photo else { return }
        photoViewModel.fetchImage(prefix: photo.prefix,
                                  suffix: photo.suffix,
                                  size: PhotoViewConstants.imageSize) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print("Error fetching image: \(error)")
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.photoView.image = UIImage(data: imageData)
                }
            }
        }
        
        //Adjust constraints
        photoView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        let constraints = [
            photoView.topAnchor.constraint(equalTo: closeButton.topAnchor, constant: 60),
            photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            photoView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
