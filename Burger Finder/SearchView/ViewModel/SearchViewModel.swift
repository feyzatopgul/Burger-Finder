//
//  SearchViewModel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/30/22.
//

import Foundation
import CoreLocation

class SearchViewModel {
    
    private let networkManager: NetworkManagerProtocol
    private let imageLoader: ImageLoaderProtocol
    private let locationManager: LocationManagerProtocol
    private let networkReachability: NetworkReachabilityProtocol
    
    var searchedPlaces = [Place]()
    var placeText = ""
    var locationText = ""
    var mapViewHidden = true
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared,
         imageLoader: ImageLoaderProtocol = ImageLoader.shared,
         locationManager: LocationManagerProtocol = LocationManager.shared,
         networkReachability: NetworkReachabilityProtocol = NetworkReachability.shared) {
        self.networkManager = networkManager
        self.imageLoader = imageLoader
        self.locationManager = locationManager
        self.networkReachability = networkReachability
    }
    
    func fetchSearchedPlaces(search: String, location: String, completion: @escaping (Error?) -> Void) {
        if !location.isEmpty {
            //If there is a location that is searched it fetches the places based on that location
            locationManager.findLocation(query: location) { [weak self] returnedCoordinate in
                guard let self = self else { return }
                if let validCoordinate = returnedCoordinate {
                    let formattedCoordinate = String(validCoordinate.latitude) + "," + String(validCoordinate.longitude)
                    let urlString = NetworkConstants.createUrlStringForSearch(search: search, location: formattedCoordinate, sort: "DISTANCE", limit: 50)
                    guard let request = self.networkManager.createRequest(for: urlString) else { return }
                    
                    self.networkManager.executeRequest(request: request, forType: Places.self) { places, error in
                        if let error = error {
                            completion(error)
                        }
                        if let places = places {
                            self.searchedPlaces = places.results
                            completion(nil)
                        }
                    }
                }
            }
        } else {
            //If the location is empty it fetches the places based on the current location
            locationManager.resolvedCurrentLocation { resolvedCoordinate in
                guard let currentCoordinate = resolvedCoordinate else { return }
                let formattedCoordinate = String(currentCoordinate.latitude) + "," + String(currentCoordinate.longitude)
                let urlString = NetworkConstants.createUrlStringForSearch(search: search, location: formattedCoordinate, sort: "DISTANCE", limit: 50)
                guard let request = self.networkManager.createRequest(for: urlString) else { return }
                self.networkManager.executeRequest(request: request, forType: Places.self) { places, error in
                    if let error = error {
                        completion(error)
                    }
                    if let places = places {
                        self.searchedPlaces = places.results
                        completion(nil)
                    }
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
    
    //Check if network is connected or not
    func isNetworkConnected(completion: @escaping ((Bool) -> Void)) {
        if networkReachability.isConnectedToNetwork(){
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func getCoordinate(location: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        //If the location is not empty it returns the searched location coordinate
        if !location.isEmpty {
            locationManager.findLocation(query: location) { returnedCoordinate in
                if let coordinate = returnedCoordinate {
                    completion(coordinate)
                }
            }
        } else {
            //If the location is empty it returns the current location coordinate
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


