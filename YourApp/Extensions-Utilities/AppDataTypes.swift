//
//  AppDataTypes.swift
//  YourApp
//
//  Created by J C on 2020-12-14.
//

import UIKit

struct GestureNames {
    static let enlarge = "enlarge"
    static let normal = "normal"
    static let longPress = "longPress"
}

struct CellNames {
    static let cell = "cell"
    static let customCell = "customCell"
}

struct AnimationName {
    static let customTransitionVC = "CustomTransitionVC"
    static let prgr = "Pinch Rotate Gesture Recognizer"
    static let snap = "UISnapBehavior"
    static let scroll = "Scroll View Zoom"
    static let page = "Page"
    static let autoScroll = "Auto Scroll"
    static let customTable = "Custom Table"
    static let gps = "GPS"
    static let carousal = "Carousal"
    static let dynamic = "Dynamic"
    static let activity = "Activity"
    static let basicAVCompVC = "Basic AVComposition"
    static let videoEdit = "Video Edit"
    static let sideMenu = "Side Menu"
}

struct MenuData {
    let imageName: String
    let title: String
    let subTitle: String
    let price: String
}

class TouchableView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { (_) in
                NotificationCenter.default.post(name: .CustomViewTapped, object: self)
            }
        }
    }
}
