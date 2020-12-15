//
//  ArrowView.swift
//  YourApp
//
//  Created by J C on 2020-12-15.
//

import UIKit

class ArrowLayer: CAShapeLayer {
    var width: CGFloat!
    var height: CGFloat!
    var triangleColor: CGColor!
    
    init(width: CGFloat, height: CGFloat, color: CGColor) {
        super.init()
        self.width = width
        self.height = height
        self.triangleColor = color
        self.createTriangle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTriangle() {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: .zero)
        trianglePath.addLine(to: CGPoint(x: width, y: height/2))
        trianglePath.addLine(to: CGPoint(x: 0.0, y: height))
        trianglePath.close()
        
        self.path = trianglePath.cgPath
        self.strokeColor = triangleColor
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 10
        self.lineCap = .round
        self.lineJoin = .round
        self.transform = CATransform3DMakeScale(0.4, 0.4, 1)
    }
}
