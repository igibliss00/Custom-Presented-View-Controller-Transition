//
//  RootViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-08.
//

import UIKit

class PlayerVC: UIViewController {
    var tag: Int!
    var tappedLocation: CGPoint!
    var tappedViewFrame: UIView!
    var window: UIWindow!
    var gestureName: String!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var image: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet var progressView: UIView!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var panelView: UIStackView!
    @IBOutlet weak var playback: UIView!
    @IBOutlet weak var previous: UIView!
    @IBOutlet weak var nextSong: UIView!
    
    init(tag: Int, tappedViewFrame: UIView, tappedLocation: CGPoint, window: UIWindow, gestureName: String) {
        super.init(nibName: "PlayerVC", bundle: nil)
        self.tag = tag
        self.tappedViewFrame = tappedViewFrame
        self.tappedLocation = tappedLocation
        self.window = window
        self.gestureName = gestureName
        
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.playback.addGestureRecognizer(tap)
        
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "\(String(describing: self.tag!)).jpg")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        
    }

    @IBAction func doButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated:true)
    }
}

extension PlayerVC : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = MyPresentationController(presentedViewController: presented, presenting: presenting)
        return pc
    }
}

class MyPresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView : CGRect {
        return super.frameOfPresentedViewInContainerView.insetBy(dx: 0, dy: 0)
    }
}

// ==========================
extension MyPresentationController {
    override func presentationTransitionWillBegin() {
        let con = self.containerView!
        let shadow = UIView(frame:con.bounds)
        shadow.backgroundColor = UIColor(white:0, alpha:0.4)
        con.insertSubview(shadow, at: 0)
        // deal with what happens on rotation
        shadow.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // can play tricks with the presenting view just like phone sheet
        if let tc = self.presentingViewController.transitionCoordinator {
            tc.animate { _ in
                if self.traitCollection.userInterfaceIdiom == .phone {
//                    self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }
            }
        }
    }
}

// ==========================
extension MyPresentationController {
    override func dismissalTransitionWillBegin() {
        let con = self.containerView!
        let shadow = con.subviews[0]
        if let tc = self.presentedViewController.transitionCoordinator {
            tc.animate { _ in
                shadow.alpha = 0
                self.presentingViewController.view.transform = .identity
            }
        }
    }
}


// ===========================
extension MyPresentationController {
    override var presentedView : UIView? {
        let v = super.presentedView!
        v.layer.cornerRadius = 6
        v.layer.masksToBounds = true
        return v
    }
    //    override func shouldRemovePresentersView() -> Bool {
    //        return true
    //    }
}


// ===========================
extension MyPresentationController {
    override func presentationTransitionDidEnd(_ completed: Bool) {
        let vc = self.presentingViewController
        let v = vc.view
        v?.tintAdjustmentMode = .dimmed
    }
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        let vc = self.presentingViewController
        let v = vc.view
        v?.tintAdjustmentMode = .automatic
    }
}


// ==========================
extension PlayerVC /*: UIViewControllerTransitioningDelegate*/ {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch self.gestureName {
            case GestureNames.enlarge:
                return EnlargeAnimationController(tappedView: self.tappedViewFrame, tappedLocation: self.tappedLocation, window: self.window)
            case GestureNames.normal:
                return nil
            case GestureNames.longPress:
                return nil
            default:
                return nil
        }
    }
}

// =======
extension PlayerVC {
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
