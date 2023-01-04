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
    var priceView = PriceView()
    var isOpenLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(placeImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceView)
        contentView.addSubview(isOpenLabel)
        
        configurePlaceImage()
        configureNameLabel()
        configureRatingLabel()
        configurePriceView()
        configureIsOpenLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Configure placeImage
    private func configurePlaceImage() {
        placeImage.layer.cornerRadius = 20
        placeImage.clipsToBounds = true
        placeImage.frame.size = CGSize(width: 100, height: 100)
        
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            placeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            placeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            placeImage.heightAnchor.constraint(equalToConstant: 110),
            placeImage.widthAnchor.constraint(equalToConstant: 110),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Configure nameLabel
    private func configureNameLabel(){
        nameLabel.numberOfLines = 3
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textColor = UIColor(named: SearchViewConstants.textColor)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Configure ratingLabel
    private func configureRatingLabel(){
        ratingLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        ratingLabel.textColor = .white
        ratingLabel.textAlignment = .center
        ratingLabel.backgroundColor = UIColor(named: SearchViewConstants.primaryAppColor)
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 15
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            ratingLabel.widthAnchor.constraint(equalToConstant: 40),
            ratingLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //Configure priceView
    private func configurePriceView() {
        priceView.axis = .horizontal
        priceView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            priceView.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: 20),
            priceView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(constraints)
    }
   
    //Reset priceView for preventing adding more subviews when the cell is reused
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in priceView.subviews {
            view.removeFromSuperview()
        }
    }
    //Configure isOpenLabel
    private func configureIsOpenLabel() {
        isOpenLabel.textColor = UIColor(named: SearchViewConstants.textColor)
        isOpenLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            isOpenLabel.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 10),
            isOpenLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
