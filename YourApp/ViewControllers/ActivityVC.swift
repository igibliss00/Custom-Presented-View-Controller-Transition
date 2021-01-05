//
//  ActivityVC.swift
//  YourApp
//
//  Created by J C on 2021-01-05.
//

import UIKit

class ActivityVC: UIViewController {
    var acv: UIActivityViewController!
    
    override func loadView() {
        let screenSize = UIScreen.main.bounds.size
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: screenSize.width, height: screenSize.height)))
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = "Hello"
        let url = URL(string: "http://www.google.com")!
        let image = UIImage(named: "1.jpg")!
        
        acv = UIActivityViewController(activityItems: [string, url, image], applicationActivities: nil)
        
        let button = UIButton(type: .system)
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.sizeToFit()
        view.addSubview(button)
    }
    
    @objc func pressed() {
        present(acv, animated: true, completion: nil)
    }
}
