//
//  Playback.swift
//  YourApp
//
//  Created by J C on 2020-12-14.
//

import UIKit

class Playback: UIView {
    lazy var width = self.frame.width
    lazy var newFrame = CGRect(origin: .zero, size: CGSize(width: width, height: width))
    lazy var newCenter = CGPoint(x: width/2 - 5, y: width/2)
    var pauseLayer: CAShapeLayer!
    var arrowLayer: CAShapeLayer!
    var isPaused = false {
        didSet {
            if isPaused {
                if arrowLayer != nil {
                    arrowLayer.removeFromSuperlayer()
                }
                
                let pausePath = UIBezierPath()
                pausePath.move(to: CGPoint(x: width/2 - 20, y: 40))
                pausePath.addLine(to: CGPoint(x: width/2 - 20, y: width - 40))
                
                pausePath.move(to: CGPoint(x: width/2 + 20, y: 40))
                pausePath.addLine(to: CGPoint(x: width/2 + 20, y: width - 40))
                
                pauseLayer = CAShapeLayer()
                pauseLayer.strokeColor = UIColor.white.cgColor
                pauseLayer.fillColor = UIColor.clear.cgColor
                pauseLayer.path = pausePath.cgPath
                pauseLayer.lineWidth = 5
                pauseLayer.lineCap = .round
                pauseLayer.position = newCenter
                pauseLayer.bounds = newFrame
                self.layer.addSublayer(pauseLayer)
            } else {
                if pauseLayer != nil {
                    pauseLayer.removeFromSuperlayer()
                }
                
                arrowLayer = ArrowLayer(width: width, height: width, color: UIColor.white.cgColor)
                arrowLayer.position = newCenter
                arrowLayer.bounds = newFrame
                self.layer.addSublayer(arrowLayer)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createTriangle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createTriangle() {
        let circlePath = UIBezierPath(ovalIn: newFrame)
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor("1d2d50").cgColor
        circleLayer.path = circlePath.cgPath
        circleLayer.position = newCenter
        circleLayer.bounds = newFrame
        self.layer.addSublayer(circleLayer)
        
        arrowLayer = ArrowLayer(width: width, height: width, color: UIColor.white.cgColor)
        arrowLayer.position = newCenter
        arrowLayer.bounds = newFrame
        self.layer.addSublayer(arrowLayer)
    }
}


