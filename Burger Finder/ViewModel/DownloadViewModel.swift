//
//  DownloadViewModel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation

class DownloadViewModel {
    
    private let networkManager: NetworkManagerProtocol
    private let locationManager: LocationManagerProtocol
    
    var places = Places(results: [])
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, locationManager:LocationManagerProtocol = LocationManager.shared) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    //Fetch popular places based on current location
    func fetchPopularPlacesNearby(completion: @escaping (Result<[Place], Error>) -> Void) {
        
        locationManager.resolvedCurrentLocation { [weak self] location in
            guard let self = self else { return }
            guard let currentLocation = location else { return }
            let urlString = NetworkConstants.createUrlString(search: "", location: currentLocation, sort: "POPULARITY")
            
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
    
    //Fetch nearby places based on search terms
    func fetchSearchedPlaces(search: String, location: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        let urlString = NetworkConstants.createUrlString(search: search, location: location, sort: "DISTANCE")
        
        guard let request = networkManager.createRequest(for: urlString) else { return }
        
        networkManager.executeRequest(request: request, forType: Places.self) { places, error in
            if let error = error {
                completion(.failure(error))
            }
            if let places = places {
                completion(.success(places.results))
            }
        }
       
    }
}
