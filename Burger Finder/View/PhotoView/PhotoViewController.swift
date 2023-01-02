//
//  PhotoViewController.swift
//  Burger Finder
//
//  Created by fyz on 1/1/23.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    
    var photo: Photo?
    var photoView = UIImageView()
    var closeButton = UIButton()
    var photoViewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        //Configure closeButton
        configureCloseButton()
        
        //ConfigurePhotoView
        configurePhotoView()
    }
    
}
