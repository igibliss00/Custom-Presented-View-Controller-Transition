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
        var constraints = [NSLayoutConstraint]()
        
        if let mainView = fromView.viewWithTag(3000) {
            for subview in mainView.allSubviews {
                switch subview {
                    case let sv as HeroView where sv.menuData.title == menuData.title:
                        imageView = sv.imageView
                        constraints = sv.imageConstraints
                        NSLayoutConstraint.deactivate(constraints)
                    case let sv as HorizontalHeroView where sv.menuData.title == menuData.title:
                        
                    default:
                        <#code#>
                }
            }
            
        }
//        if let mainView = fromView.viewWithTag(3000) {
//            for sv in mainView.subviews {
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
        
        // retaining old constraints before the image moved to the center
        // so that when the vc is popped, the image can find its way back
        delegate?.didGetConstraints(constraints)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toView.frame = finalFrame
        toView.alpha = 0
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, at: 0)
        containerView.insertSubview(fromView, at: 1)
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
                    imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 20),
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

class BackwardAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var menuData: MenuData!
    var constraints: [NSLayoutConstraint]
    
    init(menuData: MenuData, constraints: [NSLayoutConstraint]) {
        self.menuData = menuData
        self.constraints = constraints
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("1")
        guard let fromView = transitionContext.view(forKey: .from),
              let snapshot = fromView.snapshotView(afterScreenUpdates: true),
              let toView = transitionContext.viewController(forKey: .to)!.view else { return }

//        NSLayoutConstraint.deactivate((fromVC as! DetailMenuVC).imageConstraints)
        print("toView", toView.subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews)
        
        // make everything in fromView transparent except for the hero image view
        for subview in fromView.subviews {
            if subview is UIImageView {
//                NSLayoutConstraint.activate(constraints)
            } else {
                subview.alpha = 0
            }
        }

        NSLayoutConstraint.activate(constraints)
        
        if let toMainView = toView.viewWithTag(3000) {
            for subview in toMainView.allSubviews {
                switch subview {
                    case let sv as CustomSegmentedControl:
                        sv.delegate?.segmentedControlDidChange(menuData.title)
                    case let sv as HeroView:
                        sv.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                    case let sv as HorizontalHeroView:
                        sv.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                    default:
                        break
                }
                subview.alpha = 1

//
//                if subview is CustomSegmentedControl {
//                    (subview as! CustomSegmentedControl).delegate?.segmentedControlDidChange(menuData.title)
//                }
//
//                if subview is HeroView {
//
//                } else if
            }
        }
        
        
//        // sideMenuVC, select the original segment
//        if let toMainView = toView.viewWithTag(3000) {
//            for subview in toMainView.subviews {
//                subview.alpha = 1
//                if subview is CustomSegmentedControl {
//                    (subview as! CustomSegmentedControl).delegate?.segmentedControlDidChange(menuData.title)
//                }
//
//                for sv in subview.allSubviews {
//                    sv.alpha = 1
//                }
//            }
//        }
//
//        if let singleMenuPageVC = toView.viewWithTag(5000) {
//            // iterate through the singleMenuPageVC and change the background of the selected menu
//            // the first subview is the scroll view
//            for subview in singleMenuPageVC.subviews[0].subviews {
//                subview.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//                if (subview as? HeroView)?.menuData.title == menuData.title {
//                    subview.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//                } else if (subview as? HorizontalHeroView)?.menuData.title == menuData.title {
//                    subview.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//                }
//            }
//        }
        
        print("2")
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, at: 0)
        containerView.insertSubview(fromView, at: 1)
        containerView.insertSubview(snapshot, at: 2)
        print("3")
        let animation = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            UIView.animateKeyframes(withDuration: 2, delay: 0) {
                // reveal the single hero image view
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    snapshot.alpha = 0
                }
                
                // animate the image view to the original position
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    containerView.layoutIfNeeded()
                }
                
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    containerView.layoutIfNeeded()
                }
                
            } completion: { (_) in
                snapshot.removeFromSuperview()
//                fromView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        animation.startAnimation()
        print("4")
    }
}

protocol AnimatorDelegate: AnyObject {
    func didGetConstraints(_ constraints: [NSLayoutConstraint])
}

class DetailMenuAnimator: NSObject, UIViewControllerTransitioningDelegate, AnimatorDelegate {
    var menuData: MenuData!
    var constraints = [NSLayoutConstraint]()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let forwardAnimator = ForwardAnimator(menuData: menuData)
        forwardAnimator.delegate = self
        return forwardAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BackwardAnimator(menuData: menuData, constraints: constraints)
    }
    
    func didGetConstraints(_ constraints: [NSLayoutConstraint]) {
        self.constraints = constraints
    }
}

extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.flatMap { [$0] + $0.allSubviews }
    }
}
