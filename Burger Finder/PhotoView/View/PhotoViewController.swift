//
//  PhotoViewController.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/1/23.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    
    let photoViewModel = PhotoViewModel()
    let photoView = UIImageView()
    let closeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        //Configure closeButton
        configureCloseButton()
        
        //ConfigurePhotoView
        configurePhotoView()
        
        transitioningDelegate = self
    }
    
}
