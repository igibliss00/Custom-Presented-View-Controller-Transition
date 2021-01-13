//
//  HorizontalHeroView.swift
//  YourApp
//
//  Created by J C on 2021-01-12.
//

import UIKit

class HorizontalHeroView: TouchableView {
    var imageView: UIImageView!
    var containerView: UIView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var priceLabel: UILabel!
    var plusImageView: UIImageView!
    var menuData: MenuData!
    
    init(isHorizontal: Bool = true, menuData: MenuData) {
        super.init(frame: .zero)
        configureUI(menuData: menuData)
        setConstraints()
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        layer.cornerRadius = 50
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(menuData: MenuData) {
        // image view
        guard let image = UIImage(named: menuData.imageName) else { return }
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        // container view
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.alpha = 1
        self.addSubview(containerView)
        
        // title label
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = menuData.title
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        // sub title
        subTitleLabel = UILabel()
        subTitleLabel.textAlignment = .center
        subTitleLabel.text = menuData.subTitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subTitleLabel)
        
        // price label
        priceLabel = UILabel()
        priceLabel.textAlignment = .center
        priceLabel.text = menuData.price
        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(priceLabel)
        
        // plus
        let plusImage = UIImage(systemName: "plus.circle.fill")!.withRenderingMode(.alwaysTemplate)
        plusImageView = UIImageView(image: plusImage)
        plusImageView.tintColor = .black
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(plusImageView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // image view
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -50),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2),
            imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor),
            
            // container view
            containerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // title label
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            
            // sub title label
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            subTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            // price label
            priceLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 5),
            priceLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            priceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            // plus
            plusImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            plusImageView.widthAnchor.constraint(equalToConstant: 40),
            plusImageView.heightAnchor.constraint(equalToConstant: 40),
            plusImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
}
