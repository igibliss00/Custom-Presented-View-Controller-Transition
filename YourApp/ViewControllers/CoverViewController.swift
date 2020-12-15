//
//  CoverViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-14.
//

import UIKit

class CoverViewController: UIViewController {
    var tag: Int!
    var tappedLocation: CGPoint!
    var tappedViewFrame: UIView!
    var window: UIWindow!
    let button = UIButton()
    
    init(tag: Int, tappedViewFrame: UIView, tappedLocation: CGPoint, window: UIWindow) {
        super.init(nibName: nil, bundle: nil)
        self.tag = tag
        self.tappedViewFrame = tappedViewFrame
        self.tappedLocation = tappedLocation
        self.window = window
        
        self.transitioningDelegate = self
        if self.traitCollection.userInterfaceIdiom == .phone {
            self.modalPresentationStyle = .custom
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let screenSize = UIScreen.main.bounds.size
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: screenSize.width, height: screenSize.height)))
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "\(String(describing: self.tag!)).jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(imageView, at: 0)
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.setTitle("Dismiss", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            // button
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 100),
            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            
            // bg image
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

// returns presentation controller
extension CoverViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = MyPresentationController(presentedViewController: presented, presenting: presenting)
        return pc
    }
}

// returns animation controller
extension CoverViewController /*: UIViewControllerTransitioningDelegate*/ {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return EnlargeAnimationController(tappedView: self.tappedViewFrame, tappedLocation: self.tappedLocation, window: self.window)
    }
}

// =======
extension CoverViewController {
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
