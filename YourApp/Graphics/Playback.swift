//
//  Playback.swift
//  YourApp
//
//  Created by J C on 2020-12-14.
//

import UIKit

class Playback: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createTriangle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTriangle() {
        let circlePath = UIBezierPath(ovalIn: self.frame)
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor("1d2d50").cgColor
        circleLayer.path = circlePath.cgPath
        circleLayer.position = self.center
        circleLayer.bounds = self.frame
        self.layer.addSublayer(circleLayer)
        
        let arrowLayer = ArrowLayer(width: self.bounds.size.width, height: self.bounds.size.height, color: UIColor.white.cgColor)
        arrowLayer.position = self.center
        arrowLayer.bounds = self.frame
        self.layer.addSublayer(arrowLayer)
    }
}

