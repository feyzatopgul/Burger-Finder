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
    var imageViewModel = ImageLoadViewModel()
    let coreDataManager = CoreDataManager.shared
    
    let detailsScrollView = UIScrollView()
    let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var detailInfoView = DetailInfoView()
    var getDirectionsButton = UIButton()
    var saveBarButton = UIBarButtonItem()
    var saveButtonTapped = false
    
    typealias DataSource = UICollectionViewDiffableDataSource<PhotosSection,Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotosSection, Photo>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        title = place?.name
        view.addSubview(detailsScrollView)
        view.addSubview(photosCollectionView)
        
        //Configure saveBarButton
        configureSaveButton()
        
        //Configure detailsScrollView
        configureDetailsScrollView()
        
        //Configure detailInfoView
        configureDetailInfoView()
        
        //Configure getDirectionsButton
        configureGetDirectionsButton()
        
        configurePhotosCollectionView()
        
        //Assing photos data to photos
        guard let placePhotos = place?.photos else { return }
        photos = placePhotos
        
        applySnapshot()
    }
    
}
