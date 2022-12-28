//
//  PhotoCell.swift
//  Burger Finder
//
//  Created by fyz on 12/27/22.
//

import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotoCell"
    var placeImageView = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(placeImageView)
        configurePlaceImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Image view configuration
    func configurePlaceImageView() {
        
        placeImageView.layer.cornerRadius = 20
        placeImageView.contentMode = .scaleToFill
        placeImageView.clipsToBounds = true
        
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            placeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

