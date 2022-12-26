//
//  PlaceCell.swift
//  Burger Finder
//
//  Created by fyz on 12/25/22.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    static let identifier = "PlaceCell"
    
    var placeImage = UIImageView()
    var nameLabel = UILabel()
    var ratingLabel = UILabel()
    var priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(placeImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceLabel)
        
        configurePlaceImage()
        configureNameLabel()
        configureRatingLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //placeImage configuration
    private func configurePlaceImage() {
        placeImage.layer.cornerRadius = 20
        placeImage.clipsToBounds = true
        
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            placeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            placeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            placeImage.heightAnchor.constraint(equalToConstant: 100),
            placeImage.widthAnchor.constraint(equalToConstant: 100),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //nameLabel configuration
    private func configureNameLabel(){
        nameLabel.numberOfLines = 2
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textColor = .gray
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //ratingLabel configuration
    private func configureRatingLabel(){
        ratingLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        ratingLabel.textColor = .white
        ratingLabel.textAlignment = .center
        ratingLabel.backgroundColor = UIColor(named: "primaryAppColor")
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 10
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            ratingLabel.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
