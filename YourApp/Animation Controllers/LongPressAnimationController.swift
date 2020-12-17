//
//  File.swift
//  YourApp
//
//  Created by J C on 2020-12-14.
//

import UIKit

class LongPressAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    var anim: UIViewImplicitlyAnimating?
    var tappedView: UIView!
    var tappedLocation: CGPoint!
    var window: UIWindow!
    
    init(tappedView: UIView, tappedLocation: CGPoint, window: UIWindow) {
        self.tappedView = tappedView
        self.tappedLocation = tappedLocation
        self.window = window
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if self.anim != nil {
            return self.anim!
        }
        
        let toVC = transitionContext.viewController(forKey:.to)
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for:toVC!)
        let toView = transitionContext.view(forKey:.to)!
    
        toView.frame = finalFrame
//        toView.transform =
        containerView.addSubview(toView)
        toView.layer.cornerRadius = 20
        
        let anim = UIViewPropertyAnimator(duration: 0.4, curve: .linear) {
//            toView.transform = CGAffineTransform(translationX: <#T##CGFloat#>, y: <#T##CGFloat#>)
        }
        anim.addCompletion { _ in
            transitionContext.completeTransition(true)
        }
        
        self.anim = anim
        return anim
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let anim = self.interruptibleAnimator(using: transitionContext)
        anim.startAnimation()
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.anim = nil
    }
}
