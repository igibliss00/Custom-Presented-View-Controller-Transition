//
//  BillingMasterVC.swift
//  YourApp
//
//  Created by J C on 2021-01-16.
//

import UIKit

class BillingMasterVC: UIViewController {

    override func loadView() {
        let v = UIView()
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = UIColor.gray
    }
}
