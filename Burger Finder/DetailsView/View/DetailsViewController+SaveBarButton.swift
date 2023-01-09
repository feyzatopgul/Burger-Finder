//
//  DetailsViewController+SaveBarButton.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/28/22.
//

import Foundation
import UIKit

extension DetailsViewController {
    //Set button image filled when tapped and change with it non-filled when tapped again
    func setButtonImage() {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let heart = UIImage(systemName: DetailsViewConstants.heart, withConfiguration: configuration)!
        let heartFilled = UIImage(systemName: DetailsViewConstants.filledHeart, withConfiguration: configuration)!
        
        let buttonImage = detailsViewModel.isSaved ? heartFilled : heart
        if let button = self.saveBarButton.customView as? UIButton {
            button.setImage(buttonImage, for: .normal)
        }
    }
    
    //Configure saveBarButton
    func configureSaveButton() {
        let saveButton = UIButton()
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        saveBarButton.customView = saveButton
        setButtonImage()
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    //Animate saveBarButton when tapped
    func animateSaveButton(_ button: UIView){
        //animation starts from small
        button.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 10,
                       options: .curveLinear) { [weak self] in
            guard let self = self else { return }
            self.setButtonImage()
            //button gets back to original size
            button.transform = .identity
        }
    }
    
    //Action for saveBarButton tapped
    @objc func saveTapped() {
        detailsViewModel.isSaved.toggle()
        
        //Save button sate to CoreData
        if let place = detailsViewModel.place {
            detailsViewModel.setSavedState(placeId: place.id, isSaved: detailsViewModel.isSaved)
        }

        //Animate button when it is tapped
        if let button = saveBarButton.customView {
            animateSaveButton(button)
        }
        
        //Save or delete place
        if let place = detailsViewModel.place  {
            if detailsViewModel.isSaved {
                // place is saved if saveButtonTapped is true
                detailsViewModel.savePlace(place: place)
            } else {
                // place is deleted if saveButtonTapped is false
                detailsViewModel.deletePlace(place: place)
            }
        }
        
    }
}
