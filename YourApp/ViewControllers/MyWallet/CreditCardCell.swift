//
//  CreditCardView.swift
//  YourApp
//
//  Created by J C on 2021-01-18.
//

import UIKit

class CreditCardCell: UICollectionViewCell {
    var startingColor = UIColor(red: 175/255, green: 122/255, blue: 197/255, alpha: 1).cgColor
    var finishingColor = UIColor(red: 215/255, green: 189/255, blue: 226/255, alpha: 1).cgColor
    let backgroundColorArr = [UIColor(red: 175/255, green: 122/255, blue: 197/255, alpha: 1), UIColor(red: 255/255, green: 144/255, blue: 107/255, alpha: 1)]
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var balanceAnimationView: BalanceAnimationView!
    var cardNumberLabel: UILabel!
    var expiryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- background pattern
extension CreditCardCell {
    func drawPattern (arcCenter: CGPoint, radius: CGFloat) {
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        UIColor.white.setFill()
        path.fill(with: .overlay, alpha: 0.1)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.drawLinearGradient(in: self.bounds, startingWith: startingColor, finishingWith: finishingColor)
        
        drawPattern(arcCenter: .zero, radius: contentView.bounds.height - 50)
        drawPattern(arcCenter: CGPoint(x: contentView.bounds.maxX, y: contentView.bounds.minY), radius: contentView.bounds.height / 3)
    }
}

// MARK:- configure
extension CreditCardCell {
    func configure() {
        self.isOpaque = false
        self.backgroundColor = backgroundColorArr[0]
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 20)
        
        // title
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFontItalic(size: 20, fontWeight: .heavy)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        contentView.addSubview(titleLabel)
        
        // subtitle
        subtitleLabel = UILabel()
        subtitleLabel.text = "CARD BALANCE"
        subtitleLabel.textColor = .white
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        contentView.addSubview(subtitleLabel)
        
        // balanceAnimationView
        balanceAnimationView = BalanceAnimationView()
        balanceAnimationView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(balanceAnimationView)
        
        // card number label
        cardNumberLabel = UILabel()
        cardNumberLabel.text = "**** **** **** 156"
        cardNumberLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        cardNumberLabel.textColor = .white
        cardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardNumberLabel)
        
        // expiry label
        expiryLabel = UILabel()
        expiryLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        expiryLabel.textColor = .white
        expiryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(expiryLabel)
    }
}



// MARK:- set constraints

extension CreditCardCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            // title label
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/5),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/5),
            
            // subtitle label
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            
            // balanceAnimationView
            balanceAnimationView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5),
            balanceAnimationView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            balanceAnimationView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            balanceAnimationView.heightAnchor.constraint(equalToConstant: 50),
            
            // card number label
            cardNumberLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            cardNumberLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            cardNumberLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            
            // expiry label
            expiryLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            expiryLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
