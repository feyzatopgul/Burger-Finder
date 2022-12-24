//
//  DownloadViewModel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation

class DownloadViewModel {
    
    private let networkManager: NetworkManagerProtocol
    var places = Places(results: [])
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchPlaces(search: String, location: String, sort: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        let urlString = NetworkConstants.createUrlString(search: search, location: location, sort: sort)
        
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
