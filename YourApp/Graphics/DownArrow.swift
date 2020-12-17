//
//  DownArrow.swift
//  YourApp
//
//  Created by J C on 2020-12-16.
//

import UIKit

class DownArrow: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createArrow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createArrow() {
        let arrowPath = UIBezierPath()
        arrowPath.move(to: .zero)
        arrowPath.addLine(to: CGPoint(x: self.bounds.width/2, y: self.bounds.width/2))
        arrowPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        
        let arrowLayer = CAShapeLayer()
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.fillColor = UIColor.clear.cgColor
        arrowLayer.strokeColor = UIColor.lightGray.cgColor
        arrowLayer.lineWidth = 5
        arrowLayer.lineCap = .round
        arrowLayer.bounds = self.frame
        
        let arrowLayer2 = CAShapeLayer()
        arrowLayer2.path = arrowPath.cgPath
        arrowLayer2.fillColor = UIColor.clear.cgColor
        arrowLayer2.strokeColor = UIColor.lightGray.cgColor
        arrowLayer2.lineWidth = 2
        arrowLayer2.opacity = 0.4
        arrowLayer2.lineCap = .round
        arrowLayer2.bounds = self.frame
        
        self.layer.addSublayer(arrowLayer)
        self.layer.addSublayer(arrowLayer2)
        
        arrowLayer2.transform = CATransform3DMakeTranslation(0, 20, 0)
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        animation.toValue = 20
        animation.fromValue = 0
        animation.duration = 0.4
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.valueFunction = CAValueFunction(name: .translateY)
        animation.isRemovedOnCompletion = false
        arrowLayer2.add(animation, forKey: nil)
    }
    
}
