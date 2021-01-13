//
//  AppExtensions.swift
//  YourApp
//
//  Created by J C on 2020-12-14.
//

import UIKit

extension UIColor {
    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init("ff0000") // return red color for wrong hex input
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

// ActivityVC
extension UIActivity.ActivityType {
    // Reverse domain name notation
    static let customActivity = UIActivity.ActivityType("com.example")
}

// SideMenuVC
extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let newImage = renderer.image { (_) in
            color.setFill()
            let path = UIBezierPath(rect: rect)
            path.fill()
        }
        guard let cgImage = newImage.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

// Side Menu VC
extension Notification.Name {
    static let CustomViewTapped = Notification.Name("CustomViewTapped")
}
