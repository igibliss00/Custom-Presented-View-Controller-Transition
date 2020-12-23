//
//  ScrollVC.swift
//  YourApp
//
//  Created by J C on 2020-12-23.
//

import UIKit

class ScrollVC: UIViewController, UIScrollViewDelegate {
    let frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 400))
    lazy var sv = UIScrollView(frame: frame)
    lazy var iv = UIImageView(frame: frame)
    
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
        
        self.iv.image = UIImage(named: "5.jpg")!
        self.iv.contentMode = .scaleAspectFill
        
        iv.tag = 999
        sv.minimumZoomScale = 0.5
        sv.maximumZoomScale = 5
        sv.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("zoom")
        return sv.viewWithTag(999)
    }

}
