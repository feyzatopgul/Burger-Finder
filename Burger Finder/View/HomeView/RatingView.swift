//
//  RatingView.swift
//  Burger Finder
//
//  Created by fyz on 12/26/22.
//

import Foundation

import UIKit

class RatingView: UIStackView {
    var rating: Double? {
        didSet {
            createRatingView()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Create rating images based on rating property of place
    func createRatingImages(filled: Int) -> [UIImageView] {
        var imageViews:[UIImageView] = []
        let filledStar = UIImage(systemName: HomeViewConstants.filledStar)
        let nonFilledStar = UIImage(systemName: HomeViewConstants.star)
        
        for i in 0...4 {
            imageViews.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)))
            if i < filled / 2 {
                imageViews[i].image = filledStar
            } else {
                imageViews[i].image = nonFilledStar            }
        }
        return imageViews
    }
    
    //Create RatingView
    func createRatingView() {
        
        let intRating = rating != nil ? Int(round(rating!)) : 0
        let ratingImages = createRatingImages(filled: intRating)
        
        for ratingImage in ratingImages {
            ratingImage.tintColor = UIColor(named: HomeViewConstants.primaryAppColor)
            self.addArrangedSubview(ratingImage)
        }
    }
   
}
