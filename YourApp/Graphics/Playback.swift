//
//  Playback.swift
//  YourApp
//
//  Created by J C on 2020-12-14.
//

import UIKit

class Playback: UIView {
    var isPaused = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createTriangle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createTriangle()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        print(hitView)
        return hitView
    }
    
    func createTriangle() {
        let width = self.frame.width
        let newFrame = CGRect(origin: .zero, size: CGSize(width: width, height: width))
        let newCenter = CGPoint(x: width/2 - 5, y: width/2)

        let circlePath = UIBezierPath(ovalIn: newFrame)
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor("1d2d50").cgColor
        circleLayer.path = circlePath.cgPath
        circleLayer.position = newCenter
        circleLayer.bounds = newFrame
        self.layer.addSublayer(circleLayer)
        
        var pauseLayer: CAShapeLayer!
        var arrowLayer: CAShapeLayer!
        
        if isPaused {
            if arrowLayer != nil {
                arrowLayer.removeFromSuperlayer()
            }

            let pausePath = UIBezierPath()
            pausePath.move(to: CGPoint(x: width/2 - 20, y: 30))
            pausePath.addLine(to: CGPoint(x: width/2 - 20, y: width - 30))

            pausePath.move(to: CGPoint(x: width/2 + 20, y: 30))
            pausePath.addLine(to: CGPoint(x: width/2 + 20, y: width - 30))

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


