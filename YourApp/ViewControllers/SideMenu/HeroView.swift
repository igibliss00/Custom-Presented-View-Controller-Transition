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
    
    init(menuData: MenuData) {
        self.menuData = menuData
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configureUI() {
//        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//        layer.cornerRadius = 80
//        
//        // image view
//        guard let image = UIImage(named: menuData.imageName) else { return }
//        imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleAspectFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.transform = CGAffineTransform(translationX: 250, y: 0)
//        self.addSubview(imageView)
//        
//        // container view
//        containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.alpha = 0
//        self.addSubview(containerView)
//        
//        // title label
//        titleLabel = UILabel()
//        titleLabel.textAlignment = .center
//        titleLabel.text = menuData.title
//        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(titleLabel)
//        
//        // sub title
//        subTitleLabel = UILabel()
//        subTitleLabel.textAlignment = .center
//        subTitleLabel.text = menuData.subTitle
//        subTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(subTitleLabel)
//        
//        // price label
//        priceLabel = UILabel()
//        priceLabel.textAlignment = .center
//        priceLabel.text = menuData.price
//        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
//        priceLabel.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(priceLabel)
//        
//        // plus
//        let plusImage = UIImage(systemName: "plus.circle.fill")!.withRenderingMode(.alwaysTemplate)
//        plusImageView = UIImageView(image: plusImage)
//        plusImageView.tintColor = .black
//        plusImageView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(plusImageView)
//    }
//    
//    func setConstraints() {
//        imageConstraints = [
//            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -30),
//            imageView.heightAnchor.constraint(equalToConstant: 200),
//            imageView.widthAnchor.constraint(equalToConstant: 200),
//        ]
//        NSLayoutConstraint.activate(imageConstraints + [            
//            // container view
//            containerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -30),
//            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            containerView.heightAnchor.constraint(equalToConstant: 70),
//            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
//            
//            // title label
//            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            
//            // sub title label
//            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
//            subTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            
//            // price label
//            priceLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 5),
//            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            
//            // plus image view
//            plusImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            plusImageView.widthAnchor.constraint(equalToConstant: 40),
//            plusImageView.heightAnchor.constraint(equalToConstant: 40),
//            plusImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
//        ])
//                
//        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeCubic) {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 2) {
//                self.imageView.transform = .identity
//            }
//            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
//                self.containerView.alpha = 1
//            }
//        } completion: { (_) in
//            return
//        }
//    }
//    
//    func addGesture() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
//        self.addGestureRecognizer(tap)
//    }
//    
//    @objc func tapHandler() {
//        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseIn) {
//            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
//        } completion: { (_) in
//            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseIn) {
//                self.transform = CGAffineTransform(scaleX: 1, y: 1)
//            } completion: { (_) in
//                let wrappedValue = Wrapper<MenuData>(for: self.menuData)
//                NotificationCenter.default.post(name: .CustomViewTapped, object: self, userInfo: ["menuData" : wrappedValue])
//            }
//        }
//    }
}


