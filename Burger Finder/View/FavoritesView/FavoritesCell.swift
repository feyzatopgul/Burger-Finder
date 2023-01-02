//
//  FavoritesCell.swift
//  Burger Finder
//
//  Created by fyz on 12/28/22.
//

import Foundation
import UIKit

class FavoritesCell: UICollectionViewCell {
    static let identifier = "FavoritesCell"
    
    let nameLabel = UILabel()
    let locationLabel = UILabel()
    var ratingView = RatingView()
    let burgerIconView = UIImageView()
    let burgerView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 30
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 5
        
        contentView.addSubview(burgerView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(burgerIconView)
        
        configureNameLabel()
        configureLocationLabel()
        configureRatingView()
        configureburgerIconView()
        configurebackgroundView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //burgerView configuration
    func configurebackgroundView() {
    
        burgerView.image = UIImage(named: "burgerBackground")
        burgerView.contentMode = .scaleAspectFill
        burgerView.clipsToBounds = true
        burgerView.layer.cornerRadius = 30
        burgerView.alpha = 0.1
        
        burgerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            burgerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            burgerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            burgerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            burgerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //likedView configuration
    func configureburgerIconView() {
        burgerIconView.image = UIImage(named: "burgerIcon")
        
        burgerIconView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            burgerIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            burgerIconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    //nameLabel configuration
    func configureNameLabel() {
        nameLabel.numberOfLines = 3
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nameLabel.textColor = UIColor(named: "textColor")
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            //nameLabel.heightAnchor.constraint(equalToConstant: 70),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: ratingView.topAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //RatingView configuration
    func configureRatingView() {
       
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ratingView.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Name label configuration
    func configureLocationLabel() {
        locationLabel.numberOfLines = 3
        locationLabel.textAlignment = .left
        locationLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        locationLabel.textColor = UIColor(named: "textColor")
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Reset ratingView for preventing adding more subviews when the cell is reused
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in ratingView.subviews {
            view.removeFromSuperview()
        }
    }
    
}
