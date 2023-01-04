//
//  PhotoViewController+CloseButton.swift
//  Burger Finder
//
//  Created by fyz on 1/1/23.
//

import Foundation
import UIKit

extension PhotoViewController {
    
    //Configure closeButton
    func configureCloseButton() {
        view.addSubview(closeButton)
        let xMark = UIImage(named: PhotoViewConstants.closeIcon)
        closeButton.setImage(xMark, for: .normal)
    
        //Adjust constraints
        let guide = view.safeAreaLayoutGuide
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            closeButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 25),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
        
        //Add target
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    //Dismiss PhotoViewController when closeButton is tapped
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}
