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
    var balanceMaskView: UIView!
    var stackView: UIStackView!
    var balanceLabel: UILabel!
    var balanceLabel2: UILabel!
    var balanceLabel3: UILabel!
    var balanceLabel4: UILabel!
    var balanceLabel5: UILabel!
    var balanceLabel6: UILabel!
    var dollarSymbolLabel: UILabel!
    var commaLabel: UILabel!
    var periodLabel: UILabel!
    
    init() {
        super.init(frame: .zero)
        self.isOpaque = false
        configureUI()
        setConstraints()
        animateBalance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        // balance mask view
        balanceMaskView = UIView()
        balanceMaskView.translatesAutoresizingMaskIntoConstraints = false
        balanceMaskView.clipsToBounds = true
        self.addSubview(balanceMaskView)
        
        let texts = ["1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"] + ["1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"] + ["1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"]
                
        // dollar symbol label
        dollarSymbolLabel = createBalanceLabel(text: "$")
        
        // 1st balance label
        balanceLabel = createBalanceLabel(text: texts.shuffled().joined())
        balanceLabel.numberOfLines = 0
        
        // comma label
        commaLabel = createBalanceLabel(text: ",")
        
        // 2nd balance label
        balanceLabel2 = createBalanceLabel(text: texts.shuffled().joined())
        balanceLabel2.numberOfLines = 0
        
        // 3rd balance label
        balanceLabel3 = createBalanceLabel(text: texts.shuffled().joined())
        balanceLabel3.numberOfLines = 0
        
        // 4th balance label
        balanceLabel4 = createBalanceLabel(text: texts.shuffled().joined())
        balanceLabel4.numberOfLines = 0
        
        // period label
        periodLabel = createBalanceLabel(text: ".")
        
        // 5th balance label
        balanceLabel5 = createBalanceLabel(text: texts.shuffled().joined())
        balanceLabel5.numberOfLines = 0
        
        // 6th balance label
        balanceLabel6 = createBalanceLabel(text: texts.shuffled().joined())
        balanceLabel6.numberOfLines = 0
    }
    
    func createBalanceLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.sizeToFit()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        balanceMaskView.addSubview(label)
        return label
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // back button
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            
            // title label
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60),
            
            // balance mask view
            balanceMaskView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            balanceMaskView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            balanceMaskView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            balanceMaskView.heightAnchor.constraint(equalToConstant: 30),
            
            // dollar sign
            dollarSymbolLabel.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            dollarSymbolLabel.leadingAnchor.constraint(equalTo: balanceMaskView.leadingAnchor),
            dollarSymbolLabel.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/9),
            
            // balance label
            balanceLabel.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            balanceLabel.leadingAnchor.constraint(equalTo: dollarSymbolLabel.trailingAnchor),
            balanceLabel.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/9),
            
            // comma label
            commaLabel.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            commaLabel.leadingAnchor.constraint(equalTo: balanceLabel.trailingAnchor),
            commaLabel.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/13),
            
            // balance label
            balanceLabel2.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            balanceLabel2.leadingAnchor.constraint(equalTo: commaLabel.trailingAnchor),
            balanceLabel2.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/9),
            
            // balance label
            balanceLabel3.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            balanceLabel3.leadingAnchor.constraint(equalTo: balanceLabel2.trailingAnchor),
            balanceLabel3.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/9),
            
            // balance label
            balanceLabel4.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            balanceLabel4.leadingAnchor.constraint(equalTo: balanceLabel3.trailingAnchor),
            balanceLabel4.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/9),
            
            // period label
            periodLabel.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            periodLabel.leadingAnchor.constraint(equalTo: balanceLabel4.trailingAnchor),
            periodLabel.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/13),
            
            // balance label
            balanceLabel5.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            balanceLabel5.leadingAnchor.constraint(equalTo: periodLabel.trailingAnchor),
            balanceLabel5.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/9),
            
            // balance label
            balanceLabel6.topAnchor.constraint(equalTo: balanceMaskView.topAnchor),
            balanceLabel6.leadingAnchor.constraint(equalTo: balanceLabel5.trailingAnchor),
            balanceLabel6.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/9),
        ])
    }
    
    func animateBalance() {
        let arr = [balanceLabel, balanceLabel2, balanceLabel3, balanceLabel4, balanceLabel5, balanceLabel6]
        var i: Double = 0.0
        arr.forEach { (label) in
            label?.animatePicker(i: i)
            i += 0.1
        }
    }
    
    @objc func backButtonhandler() {
        NotificationCenter.default.post(name: .TopHeroViewTapped, object: self)
    }
}

extension UIView {
    func animatePicker(i: Double) {
        CATransaction.setDisableActions(true)
        let fromValue = self.layer.position.y
        let toValue = self.layer.position.y - 430
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.beginTime = CACurrentMediaTime() + i
        animation.duration = 0.8
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: nil)
    }
}
