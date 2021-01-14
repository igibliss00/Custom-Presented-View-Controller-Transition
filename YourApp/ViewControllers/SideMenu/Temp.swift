//
//  DetailMenuAnimator.swift
//  YourApp
//
//  Created by J C on 2021-01-12.
//

import UIKit

class DetailMenuAnimator1: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var menuData: MenuData!
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewController(forKey: .from)!.view,
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        // snapshot before the non-selected elements become transparent
        let snapshot = fromView.snapshotView(afterScreenUpdates: true)!
        var imageView: UIImageView!
        for sv in fromView.subviews {
            // tag == 1000 is SingleMenuPageVc
            if sv.tag == 1000 {
                // sv.subviews[0] is a scroll view
                for ssv in sv.subviews[0].subviews {
                    if (ssv as? HeroView)?.menuData.title == menuData.title {
                        imageView = (ssv as! HeroView).imageView
                        for sssv in ssv.subviews {
                            if !(sssv is UIImageView) {
                                sssv.alpha = 0
                            }
                        }
                        ssv.backgroundColor = .clear
                    } else if (ssv as? HorizontalHeroView)?.menuData.title == menuData.title {
                        imageView = (ssv as! HorizontalHeroView).imageView
                        for sssv in ssv.subviews {
                            if !(sssv is UIImageView) {
                                sssv.alpha = 0
                            }
                        }
                        ssv.backgroundColor = .clear
                    } else {
                        ssv.alpha = 0
                    }
                }
            } else {
                sv.alpha = 0
            }
        }
        imageView.translatesAutoresizingMaskIntoConstraints = true
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
                //                NSLayoutConstraint.activate([
                //                    imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
                //                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
                //                    imageView.widthAnchor.constraint(equalToConstant: 200),
                //                    imageView.heightAnchor.constraint(equalToConstant: 200),
                //                    imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                //                    imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100),
                //                ])
                //                containerView.layoutIfNeeded()
                
                //                let point = toView.convert(toView.center, from: toView.superview)
                //                imageView.center = point
                imageView.center = CGPoint(x: containerView.bounds.width / 2, y: 100)
            }
            
            //            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
            //                imageView.alpha = 0
            //            }
            
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
