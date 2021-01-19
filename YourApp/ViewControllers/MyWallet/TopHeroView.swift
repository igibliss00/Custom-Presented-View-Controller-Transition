//
//  TopHeroView.swift
//  YourApp
//
//  Created by J C on 2021-01-17.
//

import UIKit

class TopHeroView: UIView {
    let startingColor = UIColor(red: 175/255, green: 122/255, blue: 197/255, alpha: 1).cgColor
    let finishingColor = UIColor(red: 215/255, green: 189/255, blue: 226/255, alpha: 1).cgColor
    var button: UIButton!
    var titleLabel: UILabel!
    var balanceAnimationView: BalanceAnimationView!

    init() {
        super.init(frame: .zero)
        self.isOpaque = false
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TopHeroView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.drawLinearGradient(in: self.bounds, startingWith: startingColor, finishingWith: finishingColor)
        
        let y: CGFloat = self.bounds.size.height
        let x: CGFloat = self.bounds.size.width
        
        let path1 = UIBezierPath()
        UIColor.white.setFill()
        
        path1.move(to: CGPoint(x: 0, y: y))
        path1.addLine(to: CGPoint(x: 0, y: y - 20))
        path1.addCurve(to: CGPoint(x: x, y: y - 80), controlPoint1: CGPoint(x: x * 2 / 3, y: y), controlPoint2: CGPoint(x: x * 5 / 6, y: y - 100 * 6 / 5))
        path1.addLine(to: CGPoint(x: x, y: y))
        path1.close()
        path1.fill(with: .overlay, alpha: 0.6)
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: y))
        path2.addLine(to: CGPoint(x: 0, y: y - 65))
        path2.addCurve(to: CGPoint(x: x, y: y - 20), controlPoint1: CGPoint(x: x * 3 / 6, y: y - 100 * 5 / 5), controlPoint2: CGPoint(x: x * 2 / 3, y: y))
        path2.addLine(to: CGPoint(x: x, y: y))
        path2.close()
        path2.fill(with: .overlay, alpha: 0.6)
        
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: 0, y: y))
        path3.addLine(to: CGPoint(x: 0, y: y - 40))
        path3.addCurve(to: CGPoint(x: x, y: y - 60), controlPoint1: CGPoint(x: x * 5 / 6, y: y - 100 * 2 / 5), controlPoint2: CGPoint(x: x * 2 / 3, y: y - 10))
        path3.addLine(to: CGPoint(x: x, y: y))
        path3.close()
        path3.fill(with: .overlay, alpha: 0.5)
    }
    
    func configureUI() {
        // back button
        button = UIButton.systemButton(with: UIImage(systemName: "arrow.left")!, target: self, action: #selector(backButtonhandler))
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
        // title label
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "TOTAL BALANCE"
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        titleLabel.textColor = .white
        self.addSubview(titleLabel)
        
        // balanceAnimationView
        balanceAnimationView = BalanceAnimationView()
        balanceAnimationView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(balanceAnimationView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // back button
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            
            // title label
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60),
            
            // balanceAnimationView
            balanceAnimationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            balanceAnimationView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            balanceAnimationView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            balanceAnimationView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    
    
    @objc func backButtonhandler() {
        NotificationCenter.default.post(name: .TopHeroViewTapped, object: self)
    }
}

