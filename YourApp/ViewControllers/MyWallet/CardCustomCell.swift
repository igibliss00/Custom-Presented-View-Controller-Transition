//
//  CardCustomCell.swift
//  YourApp
//
//  Created by J C on 2021-01-17.
//

import UIKit

class CardCustomCell: UICollectionViewCell {
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    
    override var frame: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardCustomCell {
    func configure() {
        // shadow border
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        // title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        titleLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(titleLabel)
        
        // subtitle
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        subtitleLabel.textColor = .lightGray
        contentView.addSubview(subtitleLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // title label
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/3),
            
            // subtitle label
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1/2),
            subtitleLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1/2)
        ])
    }
}
