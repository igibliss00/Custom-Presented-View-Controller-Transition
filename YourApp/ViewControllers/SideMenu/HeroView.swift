//
//  HeroView.swift
//  YourApp
//
//  Created by J C on 2021-01-11.
//

import UIKit

class HeroView: UIView {
    var imageView: UIImageView!
    var containerView: UIView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var priceLabel: UILabel!
    var plusImageView: UIImageView!
    var menuData: MenuData!
    var imageConstraints = [NSLayoutConstraint]()
    var transferableConstraints = [Transferable]()
    var imageRect: CGPoint!

    init(menuData: MenuData) {
        self.menuData = menuData
        super.init(frame: .zero)
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { (_) in
                let wrappedValue = Wrapper<MenuData>(for: self.menuData)
                NotificationCenter.default.post(name: .CustomViewTapped, object: self, userInfo: ["menuData" : wrappedValue])
            }
        }
    }
}


