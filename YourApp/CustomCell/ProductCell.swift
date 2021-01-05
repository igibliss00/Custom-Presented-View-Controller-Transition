//
//  ProductCell.swift
//  YourApp
//
//  Created by J C on 2020-12-29.
//

import UIKit

class ProductCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}

extension ProductCell {
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.adjustsFontForContentSizeCategory = true
        subTitleLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        subTitleLabel.textColor = .placeholderText
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
