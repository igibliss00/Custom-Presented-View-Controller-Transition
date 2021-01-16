//
//  DetailMenuAnimator.swift
//  YourApp
//
//  Created by J C on 2021-01-12.
//

import UIKit

class ForwardAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var menuData: MenuData!
    weak var delegate: AnimatorDelegate?
    
    init(menuData: MenuData) {
        self.menuData = menuData
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        // snapshot before the non-selected elements become transparent
        let snapshot = fromView.snapshotView(afterScreenUpdates: true)!

        // make everything transparent except for the selected element
        var imageView: UIImageView!
        if let mainView = fromView.viewWithTag(3000) {
            for mainSubview in mainView.subviews {
                // find the single page vc
                if mainSubview.tag == 5000 {
                    for subview in mainSubview.allSubviews {
                        switch subview {
                            case let sv as HeroView where sv.menuData.title != menuData.title:
                                sv.alpha = 0
                            case let sv as HeroView where sv.menuData.title == menuData.title:
                                // retain the image to be animated
                                imageView = sv.imageView
                                // deactivate the constraints to be animated
                                let constraints = sv.imageConstraints
                                NSLayoutConstraint.deactivate(constraints)
                                
                                // retaining old constraints before the image moved to the center
                                // so that when the vc is popped, the image can find its way back
                                let transferableCon = sv.transferableConstraints
                                let imageRect = sv.imageRect!
                                delegate?.didGetConstraints(imageRect, constraints: transferableCon)
                                sv.backgroundColor = .clear
                                
                                // in order to prevent the image from going opague, only set the alpha of all the other subview within HeroView to 0
                                for case let ssv in sv.subviews where (ssv as? UIImageView) == nil  {
                                    ssv.alpha = 0
                                }
                            default:
                                break
                        }
                    }
                } else {
                    mainSubview.alpha = 0
                }
            }
        }
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toView.frame = finalFrame
        toView.alpha = 0
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, at: 0)
        containerView.insertSubview(fromView, at: 1)
        containerView.insertSubview(snapshot, at: 2)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: 0.55),
            imageView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 20),
        ])
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                snapshot.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
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

class BackwardAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var menuData: MenuData!
    var imageRect: CGPoint!
    var constraints: [Transferable]!
    
    init(menuData: MenuData, imageRect: CGPoint, constraints: [Transferable]) {
        self.menuData = menuData
        self.imageRect = imageRect
        self.constraints = constraints
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let fromVC = transitionContext.viewController(forKey: .from),
              let snapshot = fromView.snapshotView(afterScreenUpdates: true),
              let toView = transitionContext.viewController(forKey: .to)!.view else { return }
        
//        print("toView", toView.subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews)
        let fromVCInitialFrame = transitionContext.initialFrame(for: fromVC)
        fromView.frame = fromVCInitialFrame
        
        // deactivate the existing constraints
//        let imageCon = (fromVC as! DetailMenuVC).imageConstraints
//        NSLayoutConstraint.deactivate(imageCon)
        
        var imageView: UIImageView!
        // make everything in fromView transparent except for the hero image view
        for subview in fromView.subviews {
            print(fromView.subviews)
            if subview is UIImageView {
                // retain the image view to be animated later
                imageView = subview as? UIImageView
                NSLayoutConstraint.deactivate((subview as? UIImageView)!.constraints)
            } else {
                subview.alpha = 0
            }
        }

        // restore all the transparent elements to visibility
        if let toMainView = toView.viewWithTag(3000) {
            for subview in toMainView.allSubviews {
                switch subview {
                    case let sv as CustomSegmentedControl:
                        sv.delegate?.segmentedControlDidChange(menuData.title)
                    case let sv as HeroView where sv.menuData.title == menuData.title:
                        var constraintArr = [NSLayoutConstraint]()
                        for case let imageView as UIImageView in sv.subviews {
                            for constraint in constraints {
                                // apply the tranferred auto layouts so that the image view is back to the original position and size
                                if let c = constraint as? TransferableConstrainst {
                                    constraintArr.append(NSLayoutConstraint(item: imageView, attribute: c.attribute, relatedBy: c.relatedBy, toItem: sv, attribute: c.attribute2, multiplier: c.multiplier, constant: c.constant))
                                } else if let c = constraint as? TransferableConstantAnchor {
                                    constraintArr.append(NSLayoutConstraint(item: imageView, attribute: c.attribute, relatedBy: c.relatedBy, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: c.constant))
                                }
                            }
                        }
                        sv.addConstraints(constraintArr)
                        sv.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                    default:
                        break
                }
                subview.alpha = 1
            }
        }


//        let fromVCFinalFrame = transitionContext.finalFrame(for: fromVC)
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, at: 0)
        containerView.insertSubview(fromVC.view, at: 1)
        containerView.insertSubview(snapshot, at: 2)
        let animation = UIViewPropertyAnimator(duration: 3, curve: .linear) {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                // reveal the single hero image view
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    snapshot.alpha = 0
                }
                
                // animate the image view to the original position
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    containerView.layoutIfNeeded()
                    imageView.center = self.imageRect
                }
                
//                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
//                    fromView.frame = fromVCFinalFrame
//                }
                
            } completion: { (_) in
//                snapshot.removeFromSuperview()
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        animation.startAnimation()
    }
}

protocol AnimatorDelegate: AnyObject {
    func didGetConstraints(_ imageRect: CGPoint, constraints: [Transferable])
}

class DetailMenuAnimator: NSObject, UIViewControllerTransitioningDelegate {
    var menuData: MenuData!
    var imageRect: CGPoint!
    var constraints: [Transferable]!
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let forwardAnimator = ForwardAnimator(menuData: menuData)
        forwardAnimator.delegate = self
        return forwardAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BackwardAnimator(menuData: menuData, imageRect: imageRect, constraints: constraints)
    }
}

extension DetailMenuAnimator: AnimatorDelegate {
    func didGetConstraints(_ imageRect: CGPoint, constraints: [Transferable]) {
        self.imageRect = imageRect
        self.constraints = constraints
    }
}

extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.flatMap { [$0] + $0.allSubviews }
    }
}

extension UIView {
    func transferableConstrainst(item: Any, attribute: NSLayoutConstraint.Attribute, relatedBy: NSLayoutConstraint.Relation, toItem: Any?, attribute2: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: attribute2, multiplier: multiplier, constant: constant)
    }
}




//            if let mainView = fromView.viewWithTag(3000) {
//                for sv in mainView.subviews {
//                // tag == 5000 is SingleMenuPageVc
//                if sv.tag == 5000 {
//                    // sv.subviews[0] is a scroll view
//                    for ssv in sv.subviews[0].subviews {
//                        if (ssv as? HeroView)?.menuData.title == menuData.title {
//                            imageView = (ssv as! HeroView).imageView
//                            constraints = (ssv as! HeroView).imageConstraints
//                            NSLayoutConstraint.deactivate(constraints)
//                            for sssv in ssv.subviews {
//                                if !(sssv is UIImageView) {
//                                    sssv.alpha = 0
//                                }
//                            }
//                            ssv.backgroundColor = .clear
//                        } else if ssv is UIStackView {
//                            for sssv in ssv.subviews {
//                                if (sssv as? HorizontalHeroView)?.menuData.title == menuData.title {
//                                    imageView = (sssv as! HorizontalHeroView).imageView
//                                    constraints = (sssv as! HorizontalHeroView).imageConstraints
//                                    NSLayoutConstraint.deactivate(constraints)
//                                    for ssssv in sssv.subviews {
//                                        if !(ssssv is UIImageView) {
//                                            ssssv.alpha = 0
//                                        }
//                                    }
//                                    sssv.backgroundColor = .clear
//                                } else {
//                                    sssv.alpha = 0
//                                }
//                            }
//                        } else {
//                            ssv.alpha = 0
//                        }
//                    }
//                } else {
//                    sv.alpha = 0
//                }
//            }
//        }



