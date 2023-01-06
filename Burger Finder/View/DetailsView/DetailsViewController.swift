//
//  DetailsViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/26/22.
//

import UIKit

class DetailsViewController: UIViewController {

    let detailsViewModel = DetailsViewModel()
    
    let detailsScrollView = UIScrollView()
    let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var detailInfoView = DetailInfoView()
    var getDirectionsButton = UIButton()
    var saveBarButton = UIBarButtonItem()
    
    typealias DataSource = UICollectionViewDiffableDataSource<PhotosSection,Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotosSection, Photo>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        view.addSubview(detailsScrollView)
        view.addSubview(photosCollectionView)
        
        //Configure navigationItem titleView
        configureNavigationTitle()
        
        //Configure saveBarButton
        configureSaveButton()
        
        //Configure detailsScrollView
        configureDetailsScrollView()
        
        //Configure detailInfoView
        configureDetailInfoView()
        
        //Configure getDirectionsButton
        configureGetDirectionsButton()
        
        //Show loadingView before data is fetched from network
        configureAndShowLoadingView()
        
        //Configure photosCollectionView
        configurePhotosCollectionView()
//        
//        //Hide loadingView if network is not connected
//        if !NetworkReachability.shared.isConnectedToNetwork() {
//            hideLoadingView()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Check if the place is saved or not in CoreData
        if let place = detailsViewModel.place {
            detailsViewModel.isSaved = detailsViewModel.getSavedState(placeId: place.id)
        }
        //Set button image based on savedState
        setButtonImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //getPhotos from network
        getPhotos()
        //update photosCollectionView
        applySnapshot()
    }
    
    //Fetch photos of the place if there is any
    func getPhotos() {
        guard let place = detailsViewModel.place  else { return }
        guard let photos = place.photos else {return}
        if !photos.isEmpty {
            detailsViewModel.getPhotos(placeId: place.id) {[weak self] error in
                guard let self = self else { return }
                if let error = error {
                    print("Error in getting photos: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.hideLoadingView()
                        self.applySnapshot()
                    }
                }
            }
        } else {
            self.hideLoadingView()
        }
    }
}

