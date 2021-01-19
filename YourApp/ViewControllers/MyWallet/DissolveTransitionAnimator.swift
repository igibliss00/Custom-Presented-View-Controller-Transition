//
//  DissolveTransitionAnimator.swift
//  YourApp
//
//  Created by J C on 2021-01-18.
//

import UIKit

class DissolveTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let snapshot = fromView.snapshotView(afterScreenUpdates: true),
              let toView = transitionContext.view(forKey: .to),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let containerView = transitionContext.containerView
        
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = .white
        whiteBackgroundView.frame = containerView.bounds

        containerView.insertSubview(toView, at: 0)
        containerView.insertSubview(whiteBackgroundView, at: 1)
        containerView.insertSubview(snapshot, at: 2)
        
        toView.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        toView.alpha = 0
        
        UIView.animateKeyframes(
            withDuration: 0.9,
            delay: 0,
            options: [],
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                    fromView.alpha = 0
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {
                    snapshot.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
                    snapshot.alpha = 0
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.9, animations: {
                    whiteBackgroundView.alpha = 0
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                    toView.transform = .identity
                    toView.frame = finalFrame
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                    toView.alpha = 1
                })
            }, completion: { finished in
                snapshot.removeFromSuperview()
                whiteBackgroundView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }
}
