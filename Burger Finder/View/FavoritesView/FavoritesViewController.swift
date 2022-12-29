//
//  FavoritesViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoritePlaces = [Place]()
   
//Dummy data
//    var favoritePlaces:[Place] = [ Place(id: "123", distance: 234,
//                                         geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                         hours: Hours(openNow: true),
//                                         location: Location(locality: "Cupertino"),
//                                         name: "Burger King",
//                                         rating: 8.7),
//                                   Place(id: "3445", distance: 234,
//                                         geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                         hours: Hours(openNow: true),
//                                         location: Location(locality: "San jose"),
//                                         name: "Burger King Mc Donalds KFC Bla Bla",
//                                         rating: 3.4),
//                                   Place(id: "12543", distance: 234,
//                                         geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                         hours: Hours(openNow: true),
//                                         location: Location(locality: "Sunnyvale"),
//                                         name: "Burger King",
//                                         rating: 5.7),
//                                   Place(id: "2344", distance: 234,
//                                          geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                          hours: Hours(openNow: true),
//                                          location: Location(formattedAddress: "19399 Stevens Creek Blvd, Cupertino"),
//                                          name: "Burger King"),
//                                   Place(id: "121233", distance: 234,
//                                         geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                         hours: Hours(openNow: true),
//                                         location: Location(locality: "San Fransisco"),
//                                         name: "Burger King"),
//                                   Place(id: "987", distance: 234,
//                                         geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                         hours: Hours(openNow: true),
//                                         location: Location(locality: "Cupertino"),
//                                         name: "Burger King"),
//                                   Place(id: "8457", distance: 234,
//                                         geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                         hours: Hours(openNow: true),
//                                         location: Location(locality: "Cupertino"),
//                                         name: "Burger King"),
//                                   Place(id: "12345", distance: 234,
//                                        geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                        hours: Hours(openNow: true),
//                                        location: Location(locality: "Cupertino"),
//                                        name: "Burger King"),
//                                   Place(id: "45667", distance: 234,
//                                        geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                        hours: Hours(openNow: true),
//                                        location: Location(locality: "Palo Alto"),
//                                        name: "Burger King"),
//                                   Place(id: "7654", distance: 234,
//                                         geocodes: Geocode(main: Coordinate(latitude: 45.5, longitude: 35.4)),
//                                         hours: Hours(openNow: true),
//                                         location: Location(locality: "Cupertino"),
//                                         name: "Burger King")]
    
    let favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    typealias DataSource = UICollectionViewDiffableDataSource<FavoritesSection,Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, Place>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favorites"
        navigationItem.backButtonDisplayMode = .minimal
        
        view.addSubview(favoritesCollectionView)
        
        //configure favoritesCollectionView
        configureFavoritesCollectionView()
        
        applySnapshot()
        
        
    }

}
