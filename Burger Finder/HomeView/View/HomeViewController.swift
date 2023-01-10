//
//  ViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit
import Network

class HomeViewController: UIViewController {
    
    let homeViewModel = HomeViewModel()
    
    let searchButton = UIButton(configuration: .plain(), primaryAction: nil)
    
    let popularPlacesView = GradientView(colors: [UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor])
    let placesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let popularPlacesLabel = UILabel()
    
    let warningView = GradientView(colors: [UIColor.white.cgColor, UIColor.clear.cgColor])
    let locationWarningLabel = UILabel()
    let settingsButton = UIButton()
    let refreshButton = UIButton()
    let spinnerView = UIActivityIndicatorView()
    let networkWarningLabel = UILabel()
    
    typealias DataSource = UICollectionViewDiffableDataSource<PopularPlacesSection,Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PopularPlacesSection, Place>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set navigation back button display mode
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
        
        //Show loadingView before data is fetched from network
        configureAndShowLoadingView()
        
        //Configure warningView for checking location authorization status
        configureWarningView()
        configureLocationWarningLabel()
        configureSettingsButton()
        
        //Configure refreshButton and spinnerView for checking network status
        configureRefreshButton()
        configureSpinner()
        configureNetworkWarningLabel()
        
        //Add view controller as listener to LocationManagerDelegate
        LocationManager.shared.addListener(locationListener: self)

        //Hide loadingView and show alert if the network is not connected
        homeViewModel.isNetworkConnected{ [weak self] isConnected in
            guard let self = self else { return }
            if !isConnected {
                self.hideLoadingView()
                self.showNetworkAlert()
                self.popularPlacesLabel.isHidden = true
                self.refreshButton.isHidden = false
                self.networkWarningLabel.isHidden = false
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationNetworkEnabled()
    }

    //If the location is enabled and network is connected fetch places, if the location is not enabled show warningView
    func checkLocationNetworkEnabled() {
        homeViewModel.isLocationEnabled { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.popularPlacesView.isHidden = false
                self.warningView.isHidden = true

                //Get places list and update collection view if there is network connection
                if NetworkReachability.shared.isConnectedToNetwork() {
                    self.getPlaces()
                    self.applySnapshot()
                }
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
    
    
    //Get default popular places based on the current location
    func getPlaces() {
        homeViewModel.fetchPopularPlacesNearby { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Error in getting popular places: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.refreshButton.isHidden = true
                    self.networkWarningLabel.isHidden = true
                    self.popularPlacesLabel.isHidden = false
                    self.hideLoadingView()
                    self.applySnapshot()
                }
            }
        }
    }
    deinit {
        //Remove view controller from listeners when it is deinitialized
        LocationManager.shared.removeListener(locationListener: self)
    }
}

//Implement LocationUpdateDelegate protocol to get location updates
extension HomeViewController: LocationUpdateDelegate {
    func didLocationUpdated(){
        checkLocationNetworkEnabled() 
    }
}


