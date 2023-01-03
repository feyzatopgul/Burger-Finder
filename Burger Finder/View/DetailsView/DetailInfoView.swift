//
//  InfoView.swift
//  Burger Finder
//
//  Created by fyz on 12/26/22.
//

import Foundation
import UIKit

class DetailInfoView: UIStackView {
    var place: Place? {
        didSet {
            createDetailInfoView()
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
    
    func createDetailInfoView() {
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
                           imageName: DetailsViewConstants.location,
                           textColor: .systemGray,
                           imageColor: .systemGray)
        configureInfoStack(stack: hoursStack,
                           text: place?.hours.display,
                           imageName: DetailsViewConstants.clock, textColor: .systemGray,
                           imageColor: .systemGray)
        configurePhoneStack()
        
    }
    
    //Configures a horizontal stack for place detail info
    func configureInfoStack(stack: UIStackView, text: String?, imageName: String, textColor: UIColor, imageColor: UIColor) {
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 10
        
        let infoImage = UIImageView()
        infoImage.image = UIImage(systemName: imageName)
        infoImage.tintColor = imageColor
        
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.text = text
        infoLabel.textColor = textColor
        
        stack.addArrangedSubview(infoImage)
        stack.addArrangedSubview(infoLabel)
    }
    
    func configurePhoneStack(){
        phoneStack.axis = .horizontal
        phoneStack.alignment = .leading
        phoneStack.spacing = 10
        
        let phoneButton = UIButton()
        phoneButton.setTitle(place?.phoneNumber, for: .normal)
        phoneButton.setTitleColor(UIColor(named: DetailsViewConstants.primaryAppColor), for: .normal)
        let phoneImage = UIImage(systemName: DetailsViewConstants.filledPhone)?.withTintColor(UIColor(named: DetailsViewConstants.primaryAppColor) ?? .systemBackground, renderingMode: .alwaysOriginal)
        phoneButton.setImage(phoneImage, for: .normal)
        phoneStack.addArrangedSubview(phoneButton)
        
        //Add target
        phoneButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
    }
    
    //Call number when phone number is tapped
    @objc func callNumber() {
        guard let phoneNumber = place?.phoneNumber else { return }
        let validPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        guard let callUrl = URL(string: "tel://\(validPhoneNumber)") else { return }
        if (UIApplication.shared.canOpenURL(callUrl)) {
            UIApplication.shared.open(callUrl, options: [:], completionHandler: nil)
        }
    }
}

