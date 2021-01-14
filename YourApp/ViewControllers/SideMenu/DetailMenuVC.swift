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
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var desc: UILabel!
    var stackView: UIStackView!
    var totalPriceLabel: UILabel!
    var priceLabel: UILabel!
    var cartButton: UIButton!

    override func loadView() {
        let v = UIView()
        v.backgroundColor = .systemBackground
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeroImage()
        configureUI()
        setConstraints()
    }
    
    func configureHeroImage() {
        let imageName = menuData.imageName
        imageView = UIImageView(image: UIImage(named: imageName)!)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.55),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15)
        ])
    }
    
    func configureUI() {
        // title
        titleLabel = UILabel()
        titleLabel.text = menuData.title
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // subtitle
        subTitleLabel = UILabel()
        subTitleLabel.text = menuData.subTitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subTitleLabel)
        
        // description
        desc = UILabel()
        desc.text = """
            Slaws are some of the best make-ahead salad recipes out there. Typically made with hearty vegetables like cabbage, kale, or broccoli, they’re sturdy enough to be dressed ahead of time.
            """
        desc.numberOfLines = 0
        desc.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(stackView)
        
        // price title
        totalPriceLabel = UILabel()
        totalPriceLabel.text = "Total Price"
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalPriceLabel)
        
        // price
        priceLabel = UILabel()
        priceLabel.text = menuData.price
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        view.addSubview(priceLabel)
        
        // cart
        cartButton = UIButton.systemButton(with: UIImage(systemName: "cart.badge.plus")!, target: self, action: #selector(cartPressed))
        cartButton.tintColor = .white
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.backgroundColor = .black
        cartButton.layer.cornerRadius = cartButton.bounds.size.width / 2
        view.addSubview(cartButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // title label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            // subtite
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            
            // description
            desc.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 10),
            desc.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            desc.heightAnchor.constraint(equalToConstant: 200),
            desc.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            desc.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            // stack view
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // price title
            totalPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 10),
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
    
    @objc func cartPressed() {
        
    }
}
