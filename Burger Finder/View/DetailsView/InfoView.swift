//
//  InfoView.swift
//  Burger Finder
//
//  Created by fyz on 12/26/22.
//

import Foundation
import UIKit

class InfoView: UIStackView {
    var place: Place? {
        didSet {
            createInfoView()
        }
    }
    var addressStack = UIStackView()
    var hoursStack = UIStackView()
    var phoneStack = UIStackView()
    var ratingView = RatingView()
    var priceView = PriceView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createInfoView() {
        self.axis = .vertical
        self.spacing = 15
        self.alignment = .leading
        self.distribution = .fillProportionally
        
        self.addArrangedSubview(ratingView)
        self.addArrangedSubview(priceView)
        self.addArrangedSubview(addressStack)
        self.addArrangedSubview(hoursStack)
        self.addArrangedSubview(phoneStack)
        
        ratingView.rating = place?.rating
        priceView.price = place?.price
        
        configureInfoStack(stack: addressStack,
                           text: place?.location?.formattedAddress,
                           imageName: "location",
                           textColor: .systemGray,
                           imageColor: .systemGray)
        configureInfoStack(stack: hoursStack,
                           text: place?.hours.display,
                           imageName: "clock", textColor: .systemGray,
                           imageColor: .systemGray)
        configureInfoStack(stack: phoneStack,
                           text: place?.phoneNumber,
                           imageName: "phone.fill",
                           textColor: UIColor(named: "primaryAppColor") ?? .systemBackground,
                           imageColor: UIColor(named: "primaryAppColor") ?? .systemBackground)
        
    }
    
    //Configures a horizontal stack for place info
    func configureInfoStack(stack: UIStackView, text: String?, imageName: String, textColor: UIColor, imageColor: UIColor) {
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 10
        
        let InfoImage = UIImageView()
        InfoImage.image = UIImage(systemName: imageName)
        InfoImage.tintColor = imageColor
        
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.text = text
        infoLabel.textColor = textColor
        
        stack.addArrangedSubview(InfoImage)
        stack.addArrangedSubview(infoLabel)
    }
}

