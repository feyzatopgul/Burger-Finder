//
//  PhotoViewController+UIViewControllerTransitioningDelegate.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/7/23.
//

import Foundation
import UIKit

extension PhotoViewController: UIViewControllerTransitioningDelegate {
    //Call custom animation defined in AnimationManager for presenting view controller
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationManager(animationDuration: 1.0)
    }
}
