//
//  RootViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-08.
//

import UIKit

class ModalViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
           // NB if we want to modify the _animation_, we need to set the transitioningDelegate
        self.transitioningDelegate = self
        // if we want to modify the _presentation_, we need to set the style to custom
        // customize presentation only on iPhone
        // in iOS 13 we have a trait collection on creation
        if self.traitCollection.userInterfaceIdiom == .phone {
            self.modalPresentationStyle = .custom
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ModalViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = MyPresentationController(presentedViewController: presented, presenting: presenting)
        return pc
    }
}



// ==========================
extension ModalViewController /*: UIViewControllerTransitioningDelegate*/ {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
}

// =======
extension ModalViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tc = self.transitionCoordinator {
            tc.animate {
                _ in
                //                self.buttonTopConstraint.constant += 200
                //                self.view.layoutIfNeeded()
            }
        }
    }
}
