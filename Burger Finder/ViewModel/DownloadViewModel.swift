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
    
    private func fetchPlaces(search: String, location: String, limit: Int, sort: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        let urlString = NetworkConstants.createUrlString(search: search, location: location, sort: sort, limit: limit)
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
    
    //Fetch popular places based on current location
    func fetchPopularPlacesNearby(completion: @escaping (Result<[Place], Error>) -> Void) {
        
        locationManager.resolvedCurrentLocation { [weak self] location in
            guard let self = self else { return }
            guard let currentLocation = location else { return }
            self.fetchPlaces(search: "", location: currentLocation, limit: 10, sort: "POPULARITY") { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let places):
                    completion(.success(places))
                }
            }
        }
    }
    
    //Fetch nearby places based on search terms
    func fetchSearchedPlaces(search: String, location: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        //Search if the location is valid
        locationManager.findLocation(query: location) { [weak self] returnedLocation in
            guard let self = self else { return }
            if let validLocation = returnedLocation {
                self.fetchPlaces(search: search, location: validLocation, limit: 50, sort: "DISTANCE") { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let places):
                        completion(.success(places))
                    }
                }
            }
            //If the location is not valid search for current location
            else {
                self.locationManager.resolvedCurrentLocation { location in
                    guard let currentLocation = location else { return }
                    self.fetchPlaces(search: search, location: currentLocation, limit: 50, sort: "DISTANCE") { result in
                        switch result {
                        case .failure(let error):
                            completion(.failure(error))
                        case .success(let places):
                            completion(.success(places))
                        }
                    }
                }
            }
        }
        
       
    }
}
