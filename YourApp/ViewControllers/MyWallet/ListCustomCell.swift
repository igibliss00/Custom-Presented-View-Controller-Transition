//
//  ListCustomCell.swift
//  YourApp
//
//  Created by J C on 2021-01-18.
//

import UIKit

class ListCustomCell: UICollectionViewListCell {
    var vendorLabel = UILabel()
    var dateLabel = UILabel()
    var amountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCustomCell {
    func configure() {
        // shadow border
        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor(red: 213/225, green: 213/255, blue: 213/255, alpha: 1).cgColor
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        // vendor label
        vendorLabel.translatesAutoresizingMaskIntoConstraints = false
        vendorLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        vendorLabel.sizeToFit()
        vendorLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(vendorLabel)
        
        // date label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        dateLabel.textColor = .lightGray
        dateLabel.sizeToFit()
        contentView.addSubview(dateLabel)
        
        // amount label
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.adjustsFontForContentSizeCategory = true
        amountLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        amountLabel.sizeToFit()
        contentView.addSubview(amountLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // vendor label
            vendorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            vendorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            // date label
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            // amount label
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
