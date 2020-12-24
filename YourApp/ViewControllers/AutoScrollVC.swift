//
//  AutoScrollVC.swift
//  YourApp
//
//  Created by J C on 2020-12-23.
//

import UIKit

class AutoScrollVC: UIViewController, UIScrollViewDelegate {
    let frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 400))
    lazy var sv = UIScrollView(frame: frame)
    lazy var iv = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 800, height: 800)))
    var customView = CustomView()
    
    override func loadView() {
        let screenSize = UIScreen.main.bounds.size
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: screenSize.width, height: screenSize.height)))
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sv)
        self.sv.center = self.view.convert(self.view.center, from: self.view.superview)
        
        self.sv.addSubview(iv)
        let image = UIImage(named: "2.jpg")!
        self.iv.image = image
        self.sv.contentSize = self.iv.bounds.size
        self.iv.contentMode = .scaleAspectFill
        self.iv.isUserInteractionEnabled = true
        
        iv.tag = 999
        sv.minimumZoomScale = 1
        sv.maximumZoomScale = 2
        sv.delegate = self
        
        self.customView.bounds.size = CGSize(width: 100, height: 100)
        self.view.addSubview(customView)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panned))
        self.customView.addGestureRecognizer(pan)
        self.customView.isHidden = true
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        self.sv.addGestureRecognizer(swipe)
        self.sv.panGestureRecognizer.require(toFail: swipe)
    }
    
    @objc func swiped(_ sender: UISwipeGestureRecognizer) {
        let sv = self.sv
        let contentOffset = sv.contentOffset
        self.customView.frame.origin = sv.frame.origin
        self.customView.frame.origin.x -= self.customView.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.customView.frame.origin.x = contentOffset.x
            self.customView.isHidden = false
            sender.isEnabled = false
        }
    }
    
    @objc func panned(_ sender: UIPanGestureRecognizer) {
        guard let pannedView = sender.view else { return }
        let translation = sender.translation(in: pannedView.superview)
        var center = pannedView.center
        
        switch sender.state {
            case .began, .changed:
                center.x += translation.x
                center.y += translation.y
                pannedView.center = center
                sender.setTranslation(.zero, in: pannedView.superview)
                
                // autoscroll
                let sv = self.sv
                let location = sender.location(in: sv)
                let frame = sv.bounds
                var contentOffset = sv.contentOffset
                let contentSize = sv.contentSize
                var center = pannedView.center
                // to the right
                // how close to the edge of the frame of the phone display
                if location.x > frame.maxX - 30 {
                    // how close to the edge of the actual size of the image
                    let margin = contentSize.width - sv.bounds.maxX
                    if margin > 6 {
                        contentOffset.x += 5
                        sv.contentOffset = contentOffset
                        center.x += 5
                        pannedView.center = center
                    }
                }
                
            default:
                break
        }
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sv.viewWithTag(999)
    }
}

class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let circle = UIBezierPath(ovalIn: self.bounds)
        UIColor.red.setFill()
        circle.fill()
    }
}
