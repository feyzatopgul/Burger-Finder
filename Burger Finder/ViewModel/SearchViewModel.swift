//
//  SearchViewModel.swift
//  Burger Finder
//
//  Created by fyz on 12/30/22.
//

import Foundation

class SearchViewModel {
    
    private let networkManager: NetworkManagerProtocol
    private let imageLoader: ImageLoaderProtocol
    private let locationManager: LocationManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared,
         imageLoader: ImageLoaderProtocol = ImageLoader.shared,
         locationManager: LocationManagerProtocol = LocationManager.shared) {
        self.networkManager = networkManager
        self.imageLoader = imageLoader
        self.locationManager = locationManager
    }
    
    //Fetch nearby places based on search terms
    func fetchSearchedPlaces(search: String, location: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        //Search if the location is valid
        locationManager.findLocation(query: location) { [weak self] returnedLocation in
            guard let self = self else { return }
            if let validLocation = returnedLocation {
                let urlString = NetworkConstants.createUrlString(search: search, location: validLocation, sort: "DISTANCE", limit: 50)
                guard let request = self.networkManager.createRequest(for: urlString) else { return }
                
                self.networkManager.executeRequest(request: request, forType: Places.self) { places, error in
                    if let error = error {
                        completion(.failure(error))
                    }
                    if let places = places {
                        completion(.success(places.results))
                    }

                }
            }
            else {
                //If the location is not valid search for the current location
                self.locationManager.resolvedCurrentLocation { resolvedLocation in
                    guard let currentLocation = resolvedLocation else { return }
                    let urlString = NetworkConstants.createUrlString(search: "", location: currentLocation, sort: "DISTANCE", limit: 50)
                    guard let request = self.networkManager.createRequest(for: urlString) else { return }
                    self.networkManager.executeRequest(request: request, forType: Places.self) { places, error in
                        if let error = error {
                            completion(.failure(error))
                        }
                        if let places = places {
                            completion(.success(places.results))
                        }
                    }
                }
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
