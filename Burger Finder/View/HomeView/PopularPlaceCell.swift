//
//  PopularPlaceCell.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import UIKit

class PopularPlaceCell: UICollectionViewCell {
    
    var backView = UIView()
    var imageView = UIImageView()
    var nameLabel = UILabel()
    var ratingView = RatingView()

    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(backView)
        backView.addSubview(nameLabel)
        backView.addSubview(imageView)
        backView.addSubview(ratingView)
        
        configureBackgroundView()
        configureNameLabel()
        configureImageView()
        configureRatingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Configure backgroundView
    func configureBackgroundView(){
        backView.layer.cornerRadius = 15
        backView.backgroundColor = .tertiarySystemBackground
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    //Configure imageView
    func configureImageView() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        let constraints = [
            imageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.6),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.8),
            imageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Configure nameLabel
    func configureNameLabel() {
        nameLabel.numberOfLines = 3
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        nameLabel.textColor = UIColor(named: HomeViewConstants.textColor)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Configure ratingView
    func configureRatingView() {
        
        ratingView.axis = .horizontal
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            ratingView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            ratingView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Reset priceView for preventing adding more subviews when the cell is reused
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in ratingView.subviews {
            view.removeFromSuperview()
        }
    }
}
