//
//  PlaylistVC.swift
//  YourApp
//
//  Created by J C on 2020-12-13.
//

import UIKit

class PlaylistVC: UIViewController {
    let v = UIImageView(image: UIImage(named: "5.jpg"))
    var animator: UIDynamicAnimator!
    var snapping: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.v.image = UIImage(named: "5.jpg")
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
}
