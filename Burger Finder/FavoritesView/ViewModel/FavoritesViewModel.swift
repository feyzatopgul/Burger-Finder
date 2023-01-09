//
//  FavoritesViewModel.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/30/22.
//

import Foundation

class FavoritesViewModel {
    
    private let coreDataManager: CoreDataManagerProtocol
    var favoritePlaces = [Place]()
    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    //Fetch all saved places from CoreData
    func getSavedPlaces() {
        favoritePlaces = coreDataManager.fetchPlaces()
    }
    
    //Fetch filtered places from CoreData
    func getFilteredPlaces(searchTerm: String) {
        favoritePlaces = coreDataManager.filterPlaces(filter: searchTerm)
    }
}
