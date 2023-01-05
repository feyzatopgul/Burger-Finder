//
//  ViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeViewModel = HomeViewModel()
    
    let searchButton = UIButton(configuration: .plain(), primaryAction: nil)
    
    let popularPlacesView = GradientView(colors: [UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor])
    let placesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let popularPlacesLabel = UILabel()
    
    let warningView = GradientView(colors: [UIColor.white.cgColor, UIColor.clear.cgColor])
    let warningLabel = UILabel()
    let refreshButton = UIButton()
    let spinnerView = UIActivityIndicatorView()
    
    typealias DataSource = UICollectionViewDiffableDataSource<PopularPlacesSection,Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PopularPlacesSection, Place>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonDisplayMode = .minimal
        
        //Set up background
        setBackground(imageName: HomeViewConstants.burgerBackground)
        
        //Configure searchButton
        configureSearchButton()
        
        //Configure popularPlacesView
        configurePopularPlacesView()
        //Set data source and configure collection view
        placesCollectionView.dataSource = dataSource
        configurePlacesCollectionView()
        configurePopularPlacesLabel()
        
        //Configure warningView
        configureWarningView()
        configureWarningLabel()
        configureRefreshButton()
        configureSpinner()
        
        LocationManager.shared.locationDelegate = self
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }

    func checkLocationEnabled() {
        homeViewModel.isLocationEnabled { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.popularPlacesView.isHidden = false
                self.warningView.isHidden = true

                //Get places list and update collection view
                self.getPlaces()
                self.applySnapshot()
            } else {
                self.popularPlacesView.isHidden = true
                self.warningView.isHidden = false
            }
        }
    }
    
    //Set background image
    func setBackground(imageName: String) {
        guard let backgroundImage = UIImage(named: imageName) else {return}
        view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    
    //Get default popular places according to the current location
    func getPlaces() {
        homeViewModel.fetchPopularPlacesNearby { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Error in getting popular places: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.applySnapshot()
                }
            }
        }
    }
}

extension HomeViewController: LocationUpdateDelegate {
    func didLocationUpdated(){
        checkLocationEnabled() 
    }
}
