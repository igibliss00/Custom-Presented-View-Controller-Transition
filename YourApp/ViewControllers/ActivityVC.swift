//
//  ActivityVC.swift
//  YourApp
//
//  Created by J C on 2021-01-05.
//

import UIKit
import QuickLook

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
        
        acv = UIActivityViewController(activityItems: [string, url, image], applicationActivities: [CustomActivity()])
        acv.isModalInPresentation = true

        let button = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(pressed))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func pressed() {
        present(acv, animated: true, completion: nil)
    }
}

class CustomActivity: UIActivity {
    override class var activityCategory: UIActivity.Category {
        return .action
    }
    
    override var activityType: UIActivity.ActivityType? {
        return .customActivity
    }
    
    override var activityTitle: String? {
        return NSLocalizedString("Make it Circular", comment: "activity title")
    }
    
    override var activityImage: UIImage? {
        return UIImage(systemName: "circle")
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for case is UIImage in activityItems {
            return true
        }
        
        return false
    }
    
    var sourceImage: UIImage?
    override func prepare(withActivityItems activityItems: [Any]) {
        for case let image as UIImage in activityItems {
            self.sourceImage = image
            return
        }
    }
    
    var finalImage: UIImage?
    override func perform() {
        let bounds = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let image = renderer.image { (_) in
            UIBezierPath(ovalIn: bounds).addClip()
            sourceImage?.draw(in: bounds)
        }
        print("image", image)
        self.finalImage = image
        self.activityDidFinish(true)
    }
}


extension CustomActivity: QLPreviewControllerDataSource {
    override var activityViewController: UIViewController? {
        print("final", self.finalImage)
        guard let _ = self.finalImage else {
            print("run")
            return nil
        }
        
        let viewController = QLPreviewController()
        viewController.dataSource = self
        return viewController
    }
    
    // MARK: - QLPreviewControllerDataSource
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return self.finalImage != nil ? 1 : 0
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
//        guard let pngData = self.finalImage!.pngData() else {
//            fatalError("error")
//        }
//        return pngData as! QLPreviewItem
        guard let finalImage = self.finalImage else {
            fatalError("Error")
        }
        return finalImage as! QLPreviewItem
    }
}

