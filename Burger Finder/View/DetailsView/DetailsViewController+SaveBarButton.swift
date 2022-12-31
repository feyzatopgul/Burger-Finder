//
//  DetailsViewController+SaveBarButton.swift
//  Burger Finder
//
//  Created by fyz on 12/28/22.
//

import Foundation
import UIKit

extension DetailsViewController {
    //Set button image filled when tapped and change with it non-filled when tapped again
    func setButtonImage() {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let heart = UIImage(systemName: "heart", withConfiguration: configuration)!
        let heartFilled = UIImage(systemName: "heart.fill", withConfiguration: configuration)!
        
        let buttonImage = saveButtonTapped ? heartFilled : heart
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
        saveButtonTapped.toggle()
        //Save button state to userdefaults
        if let place = place {
            detailsViewModel.setSavedState(placeId: place.id, isSaved: saveButtonTapped)
        }
        
        //Animate button when it is tapped
        if let button = saveBarButton.customView {
            animateSaveButton(button)
        }
        //Save or delete place
        if let place = place {
            if saveButtonTapped {
                // place is saved if saveButtonTapped is true
                detailsViewModel.savePlace(place: place)
            } else {
                // place is deleted if saveButtonTapped is false
                detailsViewModel.deletePlace(place: place)
            }
        }
    }
}
