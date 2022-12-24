//
//  ViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var downloadViewModel = DownloadViewModel()
    
    var places = [Place]()
    
    let searchButton = UIButton(configuration: .plain(), primaryAction: nil)
    let placesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    typealias DataSource = UICollectionViewDiffableDataSource<PopularPlacesSection,Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PopularPlacesSection, Place>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up background
        setBackground(imageName: "burgerBackground")
        
        //Configure search field
        configureSearchButton()
        
        //Set data source and configure collection view
        placesCollectionView.dataSource = dataSource
        configurePlacesCollectionView()
        
        //Get places list and update collection view
        getPlaces()
        applySnapshot()
        
        
    }
    
    //Set background image
    func setBackground(imageName: String) {
        guard let backgroundImage = UIImage(named: imageName) else {return}
        view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    //Get default popular places according to the current location
    func getPlaces() {
        downloadViewModel.fetchPlaces(search: "", location: "Cupertino", sort: "POPULARITY") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let returnedPlaces):
                self.places = returnedPlaces
                DispatchQueue.main.async {
                    self.applySnapshot()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

