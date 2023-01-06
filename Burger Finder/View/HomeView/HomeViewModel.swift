//
//  HomeViewControllerViewModel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/30/22.
//

import Foundation
import CoreLocation

class HomeViewModel {
  
    private let networkManager: NetworkManagerProtocol
    private let locationManager: LocationManagerProtocol
    private let imageLoader: ImageLoaderProtocol
    var popularPlaces = [Place]()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared,
         locationManager:LocationManagerProtocol = LocationManager.shared,
         imageLoader: ImageLoaderProtocol = ImageLoader.shared) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        self.imageLoader = imageLoader
        locationManager.checkLocationService()
    }
    
    //Fetch popular places based on current location
    func fetchPopularPlacesNearby(completion: @escaping (Error?) -> Void) {
        
        locationManager.resolvedCurrentLocation { [weak self] returnedCoordinate in
            guard let self = self else { return }
            guard let currentCoordinate = returnedCoordinate else { return }
            let formattedCoordinate = String(currentCoordinate.latitude) + "," + String(currentCoordinate.longitude)
            let urlString = NetworkConstants.createUrlStringForSearch(search: "", location: formattedCoordinate, sort: "POPULARITY", limit: 10)
            guard let request = self.networkManager.createRequest(for: urlString) else { return }
            
            self.networkManager.executeRequest(request: request, forType: Places.self) { places, error in
                if let error = error {
                    completion(error)
                }
                if let places = places {
                    self.popularPlaces = places.results
                    completion(nil)
                }
            }
        }
    }
    
    //Check if location is enabled or not
    func isLocationEnabled(completion: @escaping ((Bool) -> Void)){
        if locationManager.isLocationEnabled {
            completion(true)
        } else {
            completion(false)
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
