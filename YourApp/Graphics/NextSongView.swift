//
//  NextSongLayer.swift
//  YourApp
//
//  Created by J C on 2020-12-15.
//

import UIKit

class NextSongView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createTriangles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTriangles() {
        let width = self.frame.width - 20
        let size = CGSize(width: width, height: width)
        let newFrame = CGRect(origin: .zero, size: size)
        let newCenter = CGPoint(x: width/2, y: width/2)

        let arrowLayer = ArrowLayer(width: size.width, height: size.width, color: UIColor("1d2d50").cgColor)
        arrowLayer.position = newCenter
        arrowLayer.bounds = newFrame
        self.layer.addSublayer(arrowLayer)
        
        let arrowLayer1 = ArrowLayer(width: size.width, height: size.width, color: UIColor("1d2d50").cgColor)
        arrowLayer1.position.y = newCenter.y
        arrowLayer1.position.x = newCenter.x + 20
        arrowLayer1.bounds = newFrame
        self.layer.addSublayer(arrowLayer1)
    }
}
