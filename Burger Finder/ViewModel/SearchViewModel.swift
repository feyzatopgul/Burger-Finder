//
//  SearchViewModel.swift
//  Burger Finder
//
//  Created by fyz on 12/30/22.
//

import Foundation
import CoreLocation

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
        if !location.isEmpty {
            locationManager.findLocation(query: location) { [weak self] returnedCoordinate in
                guard let self = self else { return }
                if let validCoordinate = returnedCoordinate {
                    let formattedCoordinate = String(validCoordinate.latitude) + "," + String(validCoordinate.longitude)
                    let urlString = NetworkConstants.createUrlStringForSearch(search: search, location: formattedCoordinate, sort: "DISTANCE", limit: 50)
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
        } else {
            locationManager.resolvedCurrentLocation { resolvedCoordinate in
                guard let currentCoordinate = resolvedCoordinate else { return }
                let formattedCoordinate = String(currentCoordinate.latitude) + "," + String(currentCoordinate.longitude)
                let urlString = NetworkConstants.createUrlStringForSearch(search: search, location: formattedCoordinate, sort: "DISTANCE", limit: 50)
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
    
    func getCoordinate(location: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        if !location.isEmpty {
            locationManager.findLocation(query: location) { returnedCoordinate in
                if let coordinate = returnedCoordinate {
                    completion(coordinate)
                }
            }
        } else {
            locationManager.resolvedCurrentLocation { returnedCoordinate in
                if let coordinate = returnedCoordinate {
                    completion(coordinate)
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
