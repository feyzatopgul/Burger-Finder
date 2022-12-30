//
//  DetailsViewController+SaveBarButton.swift
//  Burger Finder
//
//  Created by fyz on 12/28/22.
//

import Foundation
import UIKit

extension DetailsViewController {
    
    func setButtonImage() -> UIImage {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let heart = UIImage(systemName: "heart", withConfiguration: configuration)!
        let heartFilled = UIImage(systemName: "heart.fill", withConfiguration: configuration)!
        return saveButtonTapped ? heartFilled : heart
    }
    
    //Configure saveBarButton
    func configureSaveButton() {
        let saveButton = UIButton()
        saveButton.setImage(setButtonImage(), for: .normal)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        saveBarButton.customView = saveButton
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
            if let button = self.saveBarButton.customView as? UIButton {
                button.setImage(self.setButtonImage(), for: .normal)
            }
            //button gets back to original size
            button.transform = .identity
        }
    }
    
    //Action for saveBarButton tapped
    @objc func saveTapped() {
        saveButtonTapped.toggle()
        if let button = saveBarButton.customView {
            animateSaveButton(button)
        }
        if let place = place {
            if saveButtonTapped {
                // place is saved if saveButtonTapped is true
                coreDataManager.savePlace(place: place)
            } else {
                // place is deleted if saveButtonTapped is false
                coreDataManager.deletePlace(place: place)
            }
        }
        //coreDataManager.deleteAllItems()
    }
}
