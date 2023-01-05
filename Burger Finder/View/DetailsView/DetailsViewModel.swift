//
//  DetailsViewModel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/30/22.
//

import Foundation

class DetailsViewModel {
    
    private let imageLoader: ImageLoaderProtocol
    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkManagerProtocol
    private let userDefaults = UserDefaults.standard
    var placePhotos = [Photo]()
    var place: Place?
    var isSaved: Bool = false
    
    init(imageLoader: ImageLoaderProtocol = ImageLoader.shared,
         coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared,
         networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.imageLoader = imageLoader
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }
    
    //Save isSaved boolean as true in CoreData if the place is saved, save it as false if the place is unsaved
        func setSavedState(placeId: String, isSaved: Bool) {
            coreDataManager.setSavedState(placeId: placeId, isSaved: isSaved)
        }
        
        //Check if the place is saved or not from CoreData
        func getSavedState(placeId: String) -> Bool {
            let state = coreDataManager.getSavedState(placeId: placeId)
            return state
        }
    
    //Save place to CoreData
    func savePlace(place: Place) {
        coreDataManager.savePlace(place: place)
    }
    //Delete place from CoreData
    func deletePlace(place: Place){
        coreDataManager.deletePlace(place: place)
    }
    
    //Make a network call for fetching photos of a place based on placeId
    func getPhotos(placeId: String, completion: @escaping (Error?) -> Void) {
        let urlString = NetworkConstants.createUrlStringForPhotos(placeId: placeId)
        guard let request = networkManager.createRequest(for: urlString) else { return }
        
        networkManager.executeRequest(request: request, forType: [Photo].self) {[weak self] photos, error in
            guard let self = self else { return }
            if let error = error {
                completion(error)
            }
            if let photos = photos {
                self.placePhotos = photos
                completion(nil)
            }
        }
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

