//
//  CustomSegmentedControl.swift
//  YourApp
//
//  Created by J C on 2021-01-11.
//

import UIKit

protocol SegmentedControlDelegate: AnyObject {
    func segmentedControlDidChange(_ senderCurrentTitle: String)
}

class CustomSegmentedControl: UIView {
    var stackView: UIStackView!
    weak var delegate: SegmentedControlDelegate?
    
    convenience init(items: [String]) {
        // main view's width
        let width: CGFloat = UIScreen.main.bounds.width
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 50)), items: items)
    }
    
    init(frame: CGRect, items: [String]) {
        super.init(frame: frame)
        
        var arrangedSubviews = [UIButton]()
        for item in items {
            let button = UIButton(type: .custom)
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            
            // normal state
            button.setTitle(item, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setBackgroundImage(UIImage(color: UIColor(white: 0.9, alpha: 0.9)), for: .normal)
            
            // selected state
            let attributedString2 = NSMutableAttributedString(string: item, attributes: [.foregroundColor: UIColor.white])
            button.setAttributedTitle(attributedString2, for: .selected)
            button.setBackgroundImage(UIImage(color: UIColor.black), for: .selected)
            
            // target
            button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
            
            arrangedSubviews.append(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 100),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        // first button is selected
        let firstSubview = arrangedSubviews[0]
        firstSubview.tag = 1000
        firstSubview.setTitleColor(UIColor.white, for: .normal)
        firstSubview.setBackgroundImage(UIImage(color: UIColor.black), for: .normal)
        
        // stack view
        stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonHandler(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.setBackgroundImage(UIImage(color: UIColor.black), for: .normal)
        delegate?.segmentedControlDidChange(sender.currentTitle!)
        for case let subview as UIButton in stackView.subviews {
            if subview != sender {
                subview.setTitleColor(UIColor.black, for: .normal)
                subview.setBackgroundImage(UIImage(color: UIColor(white: 0.9, alpha: 1)), for: .normal)
            }
        }
    }
}
