//
//  ScrollVC.swift
//  YourApp
//
//  Created by J C on 2020-12-23.
//

import UIKit

class ScrollVC: UIViewController, UIScrollViewDelegate {
    let frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 400))
    lazy var sv = CustomScrollView(frame: frame)
    lazy var iv = UIImageView(frame: frame)
    let label = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 50), size: CGSize(width: 300, height: 200)))
    
    override func loadView() {
        let screenSize = UIScreen.main.bounds.size
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: screenSize.width, height: screenSize.height)))
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sv)
        self.sv.addSubview(iv)
        self.sv.center = self.view.convert(self.view.center, to: self.view.superview)
        self.view.addSubview(label)
        
        self.iv.image = UIImage(named: "5.jpg")!
        self.iv.contentMode = .scaleAspectFill
        self.iv.isUserInteractionEnabled = true
        
        iv.tag = 999
        sv.minimumZoomScale = 0.5
        sv.maximumZoomScale = 5
        sv.delegate = self
        // prevents zoom from overshooting the scale limit
        sv.bouncesZoom = false
        
        self.label.numberOfLines = 0
        self.label.text = "1. Pinch \n2.Double Tap"
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        self.iv.addGestureRecognizer(doubleTap)
    }
    
    @objc func doubleTapped(_ sender:  UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        let scrollView = tappedView.superview as! UIScrollView
        if scrollView.zoomScale < 1 {
            scrollView.setZoomScale(1, animated: true)
            let point = CGPoint(x: (tappedView.bounds.width - scrollView.bounds.width) / 2, y: 0)
            scrollView.setContentOffset(point, animated: false)
        } else if scrollView.zoomScale < scrollView.maximumZoomScale {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sv.viewWithTag(999)
    }
}

// centers the view when the scale goes below 1
class CustomScrollView: UIScrollView {
    override func layoutSubviews() {
        if let v = self.delegate?.viewForZooming?(in: self) {
            let scrollViewHeight = self.bounds.height
            let scrollViewWidth = self.bounds.width
            let viewHeight = v.frame.height
            let viewWidth = v.frame.width
            var viewFrame = v.frame
            
            if scrollViewHeight > viewHeight {
                viewFrame.origin.y = (scrollViewHeight - viewHeight) / 2
            } else {
                viewFrame.origin.y = 0
            }
            
            if scrollViewWidth > viewWidth {
                viewFrame.origin.x = (scrollViewWidth - viewWidth) / 2
            } else {
                viewFrame.origin.x = 0
            }
            
            v.frame = viewFrame
        }
    }
}
