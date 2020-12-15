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
        let arrowLayer = ArrowLayer(width: self.bounds.size.width, height: self.bounds.size.height, color: UIColor("1d2d50").cgColor)
        arrowLayer.position = self.center
        arrowLayer.bounds = self.frame
        self.layer.addSublayer(arrowLayer)
        
        let arrowLayer1 = ArrowLayer(width: self.bounds.size.width, height: self.bounds.size.height, color: UIColor("1d2d50").cgColor)
        arrowLayer1.position.y = self.center.y
        arrowLayer1.position.x = self.center.x + 20
        arrowLayer1.bounds = self.frame
        self.layer.addSublayer(arrowLayer1)
    }
}
