//
//  SearchViewController+MapButton.swift
//  Burger Finder
//
//  Created by fyz on 12/30/22.
//

import Foundation
import UIKit

extension SearchViewController {
    
    //Set button image listIcon when tapped and change with it to mapIcon when tapped again
    func setButtonImage() {
        let map = UIImage(named: SearchViewConstants.mapIcon)
        let list = UIImage(named: SearchViewConstants.listIcon)
        let buttonImage = mapViewHidden ? map : list
        if let button = self.mapListBarButton.customView as? UIButton {
            button.setImage(buttonImage, for: .normal)
        }
    }
    
    //Configure mapListBarButton
    func configureMapListButton() {
        let mapListButton = UIButton()
        mapListButton.addTarget(self, action: #selector(showMapView), for: .touchUpInside)
        mapListBarButton.customView = mapListButton
        setButtonImage()
        navigationItem.rightBarButtonItem = mapListBarButton
    }
    
    //Animate mapListBarButton when tapped
    func animateMapButton(_ button: UIView){
        //animation starts from small
        button.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.setButtonImage()
            //button gets back to original size
            button.transform = .identity
        }
    }
    
    @objc func showMapView() {
        mapViewHidden.toggle()
        //Animate button when tapped
        if let button = mapListBarButton.customView {
            animateMapButton(button)
        }
        if mapViewHidden {
            //Flip views while transition
            UIView.transition(with: placesTableView, duration: 0.5, options: [.transitionFlipFromLeft]) { [weak self] in
                guard let self = self else {return}
                self.mapView.isHidden = true
                self.placesTableView.isHidden = false
            }
        } else {
            //Flip views while transition
            UIView.transition(with: mapView, duration: 0.5, options: [.transitionFlipFromRight]) { [weak self] in
                guard let self = self else {return}
                self.mapView.isHidden = false
                self.placesTableView.isHidden = true
            }
        }
    }
}
