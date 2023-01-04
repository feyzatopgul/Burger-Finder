//
//  PriceView.swift
//  Burger Finder
//
//  Created by fyz on 12/26/22.
//

import Foundation
import UIKit

class PriceView: UIStackView {
    var price: Int? {
        didSet {
            createPriceView()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Create priceImages based on price property of place
    func createPriceImages(filled: Int) -> [UIImageView] {
        var imageViews:[UIImageView] = []
        let filledPrice = UIImage(systemName: SearchViewConstants.filledPrice)
        let nonFilledPrice = UIImage(systemName: SearchViewConstants.nonFilledPrice)
        
        for i in 0...3 {
            imageViews.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25)))
            if i < filled {
                imageViews[i].image = filledPrice
            } else {
                imageViews[i].image = nonFilledPrice
            }
        }
        return imageViews
    }
    
    //Create PriceView
    func createPriceView() {
        let priceImages = createPriceImages(filled: price ?? 0)
        for priceImage in priceImages {
            priceImage.tintColor = UIColor(named: SearchViewConstants.priceColor)
            self.addArrangedSubview(priceImage)
        }
    }
   
}
