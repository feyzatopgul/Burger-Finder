//
//  InfoView.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/26/22.
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
    var websiteStack = UIStackView()
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
        self.addArrangedSubview(websiteStack)
        self.addArrangedSubview(phoneStack)
        
        ratingView.rating = place?.rating
        priceView.price = place?.price
        
        configureLabelStack(stack: addressStack,
                            text: place?.location?.formattedAddress,
                           imageName: DetailsViewConstants.location,
                           textColor: .systemGray,
                           imageColor: .systemGray)
        configureLabelStack(stack: hoursStack,
                            text: place?.hours.display,
                           imageName: DetailsViewConstants.clock, textColor: .systemGray,
                           imageColor: .systemGray)
        configureButtonStack(stack: websiteStack,
                             text: place?.website,
                             imageName: DetailsViewConstants.web,
                             textColor: UIColor(named: DetailsViewConstants.primaryAppColor) ?? .systemGray,
                             imageColor: UIColor(named: DetailsViewConstants.primaryAppColor) ?? .systemGray,
                             selector: #selector(openWebsite))
        configureButtonStack(stack: phoneStack,
                             text: place?.phoneNumber,
                             imageName: DetailsViewConstants.filledPhone,
                             textColor: UIColor(named: DetailsViewConstants.primaryAppColor) ?? .systemGray,
                             imageColor: UIColor(named: DetailsViewConstants.primaryAppColor) ?? .systemGray,
                             selector: #selector(callNumber))
        
    }
    
    //Configures a horizontal stack with an info image and label
    func configureLabelStack(stack: UIStackView, text: String?, imageName: String, textColor: UIColor, imageColor: UIColor) {
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
    
    //Configures a horizontal stack for phoneInfo with an image and button
    func configureButtonStack(stack: UIStackView, text: String?, imageName: String, textColor: UIColor, imageColor: UIColor, selector: Selector){
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 10
        
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        let image = UIImage(systemName: imageName)?.withTintColor(imageColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        stack.addArrangedSubview(button)
        
        //Add target
        button.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    //Call number when phoneStack button is tapped
    @objc func callNumber() {
        guard let phoneNumber = place?.phoneNumber else { return }
        let validPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        guard let callUrl = URL(string: "tel://\(validPhoneNumber)") else { return }
        if (UIApplication.shared.canOpenURL(callUrl)) {
            UIApplication.shared.open(callUrl, options: [:], completionHandler: nil)
        }
    }
    
    //Open website when websiteStack button is tapped
    @objc func openWebsite(){
        guard let website = place?.website else { return }
        guard let webUrl = URL(string: website) else { return }
        if (UIApplication.shared.canOpenURL(webUrl)) {
            UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        }
    }
}

