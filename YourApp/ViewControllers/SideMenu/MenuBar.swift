//
//  MenuBar.swift
//  YourApp
//
//  Created by J C on 2021-01-12.
//

import UIKit

class MenuBar: UIView {
    var containerView: UIView!
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 25
        containerView.clipsToBounds = true
        self.addSubview(containerView)
        
        let symbols: [String] = ["house", "rectangle.stack", "text.bubble", "person"]
        var symbolArr: [UIImageView] = []
        for symbol in symbols {
            let config = UIImage.SymbolConfiguration(pointSize: 20)
            let image = UIImage(systemName: symbol)!.withConfiguration(config)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .white
            symbolArr.append(imageView)
        }
        
        stackView = UIStackView(arrangedSubviews: symbolArr)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        containerView.addSubview(stackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // container view
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // stack view
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
