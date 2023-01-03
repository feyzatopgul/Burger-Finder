//
//  FavoritesViewModel.swift
//  Burger Finder
//
//  Created by fyz on 12/30/22.
//

import Foundation

class FavoritesViewModel {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    //Fetch all saved places from CoreData
    func getSavedPlaces() -> [Place] {
        return coreDataManager.fetchPlaces()
    }
    
    //Fetch filtered places from CoreData
    func getFilteredPlaces(searchTerm: String) -> [Place] {
        return coreDataManager.filterPlaces(filter: searchTerm)
    }
}
