//
//  NearbyPlaceCell.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class PopularPlaceCell: UICollectionViewCell {
    
    static let identifier = "PopularPlaceCell"
    var backView = UIView()
    var imageView = UIImageView()
    var nameLabel = UILabel()
    var ratingLabel = UILabel()

    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(backView)
        backView.addSubview(nameLabel)
        backView.addSubview(imageView)
        backView.addSubview(ratingLabel)
        
        configureBackgroundView()
        configureNameLabel()
        configureImageView()
        configureRatingLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Background view configuration
    func configureBackgroundView(){
        backView.layer.cornerRadius = 15
        backView.backgroundColor = .tertiarySystemBackground
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    //Image view configuration
    func configureImageView() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        let constraints = [
            imageView.topAnchor.constraint(equalTo: backView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            //imageView.heightAnchor.constraint(equalToConstant: backView.frame.height / 3),
            imageView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Name label configuration
    func configureNameLabel() {
        nameLabel.numberOfLines = 3
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        nameLabel.textColor = .darkGray
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30),
            nameLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Rating label configuration
    func configureRatingLabel() {
        ratingLabel.textColor = .orange
        ratingLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            ratingLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            ratingLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30),
            ratingLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
