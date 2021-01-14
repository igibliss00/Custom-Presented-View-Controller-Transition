//
//  DetailMenuAnimator.swift
//  YourApp
//
//  Created by J C on 2021-01-12.
//

import UIKit

class DetailMenuAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var menuData: MenuData!

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewController(forKey: .from)!.view,
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        // snapshot before the non-selected elements become transparent
        let snapshot = fromView.snapshotView(afterScreenUpdates: true)!

        // make everything transparent except for the selected element
        var imageView: UIImageView!
        if let mainView = fromView.viewWithTag(3000) {
            for sv in mainView.subviews {
                // tag == 5000 is SingleMenuPageVc
                if sv.tag == 5000 {
                    // sv.subviews[0] is a scroll view
                    for ssv in sv.subviews[0].subviews {
                        if (ssv as? HeroView)?.menuData.title == menuData.title {
                            imageView = (ssv as! HeroView).imageView
                            NSLayoutConstraint.deactivate((ssv as! HeroView).imageConstraints)
                            for sssv in ssv.subviews {
                                if !(sssv is UIImageView) {
                                    sssv.alpha = 0
                                }
                            }
                            ssv.backgroundColor = .clear
                        } else if ssv is UIStackView {
                            for sssv in ssv.subviews {
                                if (sssv as? HorizontalHeroView)?.menuData.title == menuData.title {
                                    imageView = (sssv as! HorizontalHeroView).imageView
                                    NSLayoutConstraint.deactivate((sssv as! HorizontalHeroView).imageConstraints)
                                    for ssssv in sssv.subviews {
                                        if !(ssssv is UIImageView) {
                                            ssssv.alpha = 0
                                        }
                                    }
                                    sssv.backgroundColor = .clear
                                } else {
                                    sssv.alpha = 0
                                }
                            }
                        } else {
                            ssv.alpha = 0
                        }
                    }
                } else {
                    sv.alpha = 0
                }
            }
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toView.frame = finalFrame
        toView.alpha = 0
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, at: 0)
        containerView.insertSubview(fromView, at: 1)
        //        containerView.insertSubview(imageView, at: 1)
        containerView.insertSubview(snapshot, at: 2)
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                snapshot.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: 0.55),
                    imageView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
                    imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 15),
                ])
                containerView.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 0.3) {
                toView.alpha = 1
            }
        } completion: { (_) in
            snapshot.removeFromSuperview()
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}


extension DetailMenuAnimator: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
