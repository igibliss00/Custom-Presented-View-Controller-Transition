//
//  DetailMenuVC.swift
//  YourApp
//
//  Created by J C on 2021-01-12.
//

import UIKit

class DetailMenuVC: UIViewController {
    var menuData: MenuData!
    var imageView: UIImageView!
    var backButton: UIButton!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var desc: UILabel!
    var stackView: UIStackView!
    var totalPriceLabel: UILabel!
    var priceLabel: UILabel!
    var cartButton: UIButton!
    var imageConstraints = [NSLayoutConstraint]()

    override func loadView() {
        let v = UIView()
        v.backgroundColor = .systemBackground
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        v.tag = 100
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeroImage()
        configureUI()
        setConstraints()
        configureAnimation()
//        perform(#selector(configureAnimation), with: nil, afterDelay: 0)

    }
    
    func configureHeroImage() {
        let imageName = menuData.imageName
        imageView = UIImageView(image: UIImage(named: imageName)!)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageConstraints = [
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.55),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
    }
    
    func configureUI() {
        // back button
        backButton = UIButton.systemButton(with: UIImage(systemName: "chevron.backward")!, target: self, action: #selector(buttonHandler))
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .black
        backButton.tag = 1
        view.addSubview(backButton)
        
        // title
        titleLabel = UILabel()
        titleLabel.text = menuData.title
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.alpha = 0
        
        // subtitle
        subTitleLabel = UILabel()
        subTitleLabel.text = menuData.subTitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.alpha = 0
        view.addSubview(subTitleLabel)
        
        // description
        desc = UILabel()
        desc.text = """
            Slaws are some of the best make-ahead salad recipes out there. Typically made with hearty vegetables like cabbage, kale, or broccoli, they’re sturdy enough to be dressed ahead of time.
            """
        desc.numberOfLines = 0
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.alpha = 0
        desc.isOpaque = false
        view.addSubview(desc)
        
        // arrows
        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 7)
        let leftArrow = UIImage(systemName: "arrow.backward.square.fill", withConfiguration: smallConfiguration)!.withRenderingMode(.alwaysOriginal)
        let rightArrow = UIImage(systemName: "arrow.right.square.fill", withConfiguration: smallConfiguration)!.withRenderingMode(.alwaysOriginal)
        let leftArrowIV = UIImageView(image: leftArrow)
        leftArrowIV.contentMode = .scaleAspectFit
        let rightArrowIV = UIImageView(image: rightArrow)
        rightArrowIV.contentMode = .scaleAspectFit
        
        let numberLabel = UILabel()
        numberLabel.text = "1"
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        
        // stack view
        stackView = UIStackView(arrangedSubviews: [leftArrowIV, numberLabel, rightArrowIV])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alpha = 0
        stackView.isOpaque = false
        view.addSubview(stackView)
        
        // price title
        totalPriceLabel = UILabel()
        totalPriceLabel.text = "Total Price"
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.alpha = 0
        totalPriceLabel.isOpaque = false
        view.addSubview(totalPriceLabel)
        
        // price
        priceLabel = UILabel()
        priceLabel.text = menuData.price
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        priceLabel.alpha = 0
        priceLabel.isOpaque = false
        view.addSubview(priceLabel)
        
        // cart
        cartButton = UIButton.systemButton(with: UIImage(systemName: "cart.badge.plus")!, target: self, action: #selector(buttonHandler))
        cartButton.tintColor = .white
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.backgroundColor = .black
        cartButton.layer.cornerRadius = 50
        cartButton.alpha = 0
        view.addSubview(cartButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // back button
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            // title label
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            // subtite
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            
            // description
            desc.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 10),
            desc.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            desc.heightAnchor.constraint(equalToConstant: 120),
            desc.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            desc.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            // stack view
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // price title
            totalPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -10),
            totalPriceLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            
            // price
            priceLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
            
            // cart
            cartButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            cartButton.heightAnchor.constraint(equalToConstant: 100),
            cartButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func buttonHandler(_ sender: UIButton) {
        if case let tag = sender.tag, tag == 1 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func configureAnimation() {
        let animation = UIViewPropertyAnimator(duration: 3, curve: .linear)
        animation.addAnimations {
            UIView.animateKeyframes(withDuration: 0, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) { [weak self] in
                    self?.titleLabel.alpha = 1
                    self?.stackView.alpha = 1
                }

                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) { [weak self] in
                    self?.subTitleLabel.alpha = 1
                    self?.desc.alpha = 1
                }

                UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) { [weak self] in
                    self?.totalPriceLabel.alpha = 1
                }

                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) { [weak self] in
                    self?.priceLabel.alpha = 1
                }

                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) { [weak self] in
                    self?.cartButton.alpha = 1
                }
            }, completion: nil)
        }
        animation.startAnimation()
    }
}
