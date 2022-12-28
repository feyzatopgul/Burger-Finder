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
    
    let detailsScrollView = UIScrollView()
    let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var detailInfoView = DetailInfoView()
    var getDirectionsButton = UIButton()
    
    typealias DataSource = UICollectionViewDiffableDataSource<PhotosSection,Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotosSection, Photo>
    lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        title = place?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        view.addSubview(detailsScrollView)
        view.addSubview(photosCollectionView)
        
        configureDetailsScrollView()
        
        //Configure detailInfoView
        configureDetailInfoView()
        
        //Configure getDirectionsButton
        configureGetDirectionsButton()
        
        configurePhotosCollectionView()
        
        guard let placePhotos = place?.photos else { return }
        photos = placePhotos
        
        applySnapshot()
    }
    
    @objc func saveTapped() {
        
    }
}
