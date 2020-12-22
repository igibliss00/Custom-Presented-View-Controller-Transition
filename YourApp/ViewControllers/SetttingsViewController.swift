//
//  SetttingsViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-21.
//

import UIKit

class SetttingsViewController: UIViewController {

    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "2.jpg")
        imageView.image = image
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        imageView.addGestureRecognizer(pinch)
        
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotated))
        imageView.addGestureRecognizer(rotate)
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
            print(gestureRecognizer.state)
        }
    }
    

}
