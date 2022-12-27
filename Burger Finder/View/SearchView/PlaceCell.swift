//
//  PlaceCell.swift
//  Burger Finder
//
//  Created by fyz on 12/25/22.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    static let identifier = "PlaceCell"
    
    //var placeCellStack = UIStackView()
    var placeImage = UIImageView()
    var nameLabel = UILabel()
    var ratingLabel = UILabel()
    var priceView = PriceView()
    var isOpenLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //contentView.addSubview(placeCellStack)
        contentView.addSubview(placeImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceView)
        contentView.addSubview(isOpenLabel)
        
        //configurePlaceCellStack()
        configurePlaceImage()
        configureNameLabel()
        configureRatingLabel()
        configurePriceView()
        configureIsOpenLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func configurePlaceCellStack(){
//        placeCellStack.axis = .horizontal
//
//        let infoStack = UIStackView()
//        infoStack.axis = .vertical
//        infoStack.alignment = .leading
//        infoStack.spacing = 15
//        infoStack.addArrangedSubview(nameLabel)
//        infoStack.addArrangedSubview(priceView)
//
//        placeCellStack.alignment = .leading
//        placeCellStack.spacing = 5
//        placeCellStack.addArrangedSubview(placeImage)
//        placeCellStack.addArrangedSubview(infoStack)
//        placeCellStack.addArrangedSubview(ratingLabel)
//
//        placeCellStack.translatesAutoresizingMaskIntoConstraints = false
//        let constraints = [
//            placeCellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            placeCellStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            placeCellStack.topAnchor.constraint(equalTo: contentView.topAnchor),
//            placeCellStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ]
//        NSLayoutConstraint.activate(constraints)
//
//    }
    
    //placeImage configuration
    private func configurePlaceImage() {
        placeImage.layer.cornerRadius = 20
        placeImage.clipsToBounds = true
        placeImage.frame.size = CGSize(width: 100, height: 100)
        
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
        nameLabel.textColor = UIColor(named: "textColor")

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30)
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
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            ratingLabel.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //priceView configuration
    private func configurePriceView() {
        
        priceView.axis = .horizontal
        
        priceView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            priceView.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: 20),
            priceView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(constraints)
    }
   
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //Reset priceView for preventing adding more subviews when the cell is reused
        for view in priceView.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func configureIsOpenLabel() {
        
        isOpenLabel.textColor = UIColor(named: "textColor")
        isOpenLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        isOpenLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            isOpenLabel.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 10),
            isOpenLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
