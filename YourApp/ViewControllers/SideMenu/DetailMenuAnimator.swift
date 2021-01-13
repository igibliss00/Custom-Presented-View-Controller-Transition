//
//  DetailMenuAnimator.swift
//  YourApp
//
//  Created by J C on 2021-01-12.
//

import UIKit

class DetailMenuAnimator: NSObject, UIViewControllerAnimatedTransitioning {
//    private let destinationFrame: CGRect
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to), 
              let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true) else { return }
        
        let containerView = transitionContext.containerView
        snapshot.layer.cornerRadius = CardViewController.cardCornerRadius
        snapshot.layer.masksToBounds = true
        
        containerView.insertSubview(toVC.view, at: 0)
        containerView.addSubview(snapshot)
        fromVC.view.isHidden = true
        
        toVC.view.layer.transform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2.0), 0, 1, 0)
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                snapshot.frame = self.destinationFrame
            }
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                snapshot.layer.transform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2.0), 0, 1, 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                toVC.view.layer.transform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2.0), 0, 1, 0)
                //                snapshot.layer.cornerRadius = 0
            }
        } completion: { (_) in
            toVC.view.isHidden = false
            snapshot.removeFromSuperview()
            //            fromVC.view.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
