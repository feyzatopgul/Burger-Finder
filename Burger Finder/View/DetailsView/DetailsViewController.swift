//
//  DetailsViewController.swift
//  Burger Finder
//
//  Created by fyz on 12/26/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var place: Place?
    //var photosCollectionView = UICollectionView()
    var infoView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = place?.name
        view.addSubview(infoView)
        infoView.place = place
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }

}
