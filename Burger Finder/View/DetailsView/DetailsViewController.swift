//
//  DetailsViewController.swift
//  Burger Finder
//
//  Created by fyz on 12/26/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var place: Place?
    var photos = [Photo]()
    var detailsViewModel = DetailsViewModel()
    
    let detailsScrollView = UIScrollView()
    let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var detailInfoView = DetailInfoView()
    var getDirectionsButton = UIButton()
    var saveBarButton = UIBarButtonItem()
    var saveButtonTapped: Bool = false
    
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
        
        //Configure photosCollectionView
        configurePhotosCollectionView()
        
        getPhotos()
        applySnapshot()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let place = place {
            saveButtonTapped = detailsViewModel.getSavedState(placeId: place.id)
        }
        setButtonImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPhotos()
        applySnapshot()
    }
    
    //Fetch photos of the place
    func getPhotos() {
        guard let place = place else { return }
        detailsViewModel.getPhotos(placeId: place.id) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print("Error while fetching photos: \(error)")
            case .success(let returnedPhotos):
                self.photos = returnedPhotos
            }
        }
    }
}

