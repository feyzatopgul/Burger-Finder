//
//  PhotoViewModel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/1/23.
//

import Foundation

class PhotoViewModel {
    
    private let imageLoader: ImageLoaderProtocol
    var photo: Photo?
    
    init(imageLoader: ImageLoaderProtocol = ImageLoader.shared) {
        self.imageLoader = imageLoader
    }
    
    //Fetch image using prefix suffix properties of Photo model and size
    func fetchImage(prefix: String, suffix: String, size: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let imageUrl = prefix + size + suffix
        imageLoader.loadImage(imageUrl: imageUrl){ data, error in
            if let error = error {
                completion(.failure(error))
            }
            if let imageData = data {
                completion(.success(imageData))
            }
        }
    }
}
