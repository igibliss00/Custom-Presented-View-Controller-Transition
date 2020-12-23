//
//  PlaylistVC.swift
//  YourApp
//
//  Created by J C on 2020-12-13.
//

import UIKit

class SnapVC: UIViewController {
    let v = UIImageView(image: UIImage(named: "5.jpg"))
    var animator: UIDynamicAnimator!
    var snapping: UISnapBehavior!
    
    override func loadView() {
        let screenSize = UIScreen.main.bounds.size
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: screenSize.width, height: screenSize.height)))
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.v)
        self.v.isUserInteractionEnabled = true
        self.v.layer.cornerRadius = 20
        self.v.clipsToBounds = true
        self.v.translatesAutoresizingMaskIntoConstraints = false
        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.snapping = UISnapBehavior(item: self.v, snapTo: self.view.center)
        self.animator.addBehavior(self.snapping)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panned))
        self.v.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        self.v.addGestureRecognizer(pinch)
        
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotated))
        self.v.addGestureRecognizer(rotate)
        
        NSLayoutConstraint.activate([
            v.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            v.widthAnchor.constraint(equalToConstant: 200),
            v.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func panned(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .began:
                self.animator.removeBehavior(self.snapping)
            case .changed:
                let translation = sender.translation(in: self.v.superview)
                self.v.center = CGPoint(x: self.v.center.x + translation.x, y: self.v.center.y + translation.y)
                sender.setTranslation(.zero, in: self.v.superview)
            case .ended, .cancelled, .failed:
                self.animator.addBehavior(self.snapping)
            case .possible:
                break
            default:
                break
        }
    }
    
    @objc func rotated(_ gestureRecognizer: UIRotationGestureRecognizer) {
        guard let myView = gestureRecognizer.view else { return }
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            myView.transform = myView.transform.rotated(by: gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }
    }
    
    @objc func pinched(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))!
            gestureRecognizer.scale = 1.0
        }
    }
	}
