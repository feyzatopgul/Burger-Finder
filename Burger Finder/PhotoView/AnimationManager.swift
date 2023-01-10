//
//  AnimatedTransitionManager.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/6/23.
//

import Foundation
import UIKit

class AnimationManager : NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: Double

    init(animationDuration: Double) {
        self.animationDuration = animationDuration
    }
    
    //Sets the transition duration
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //Set the view controller that’s visible at the end of a completed transition.
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return }
        //Add toVC to the containerView for animation
        transitionContext.containerView.addSubview(toVC.view)
        //Call present animation for toVC
        presentAnimation(with: transitionContext, viewToAnimate: toVC.view)
    }
    
    //Configure animation for presenting the view controller
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView){
        viewToAnimate.clipsToBounds = true
        viewToAnimate.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        transitionContext.completeTransition(true)
    }
}
