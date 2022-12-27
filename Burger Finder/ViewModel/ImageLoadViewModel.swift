//
//  ImageLoadViewModel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation

class ImageLoadViewModel {
    
    private let imageLoader: ImageLoaderProtocol
    init(imageLoader: ImageLoaderProtocol = ImageLoader.shared){
        self.imageLoader = imageLoader
    }
    
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
