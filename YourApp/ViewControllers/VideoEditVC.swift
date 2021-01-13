//
//  VideoEditVC.swift
//  YourApp
//
//  Created by J C on 2021-01-08.
//

import UIKit

class VideoEditVC: UIViewController, UINavigationControllerDelegate & UIVideoEditorControllerDelegate {
    override func loadView() {
        let v = UIView()
        v.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(play))
        let toolBar = UIToolbar(frame: CGRect(origin: CGPoint(x: 0, y: 200), size: CGSize(width: 50, height: 50)))
        toolBar.setItems([barButton], animated: true)
        view.addSubview(toolBar)
        
    }
    
    @objc func play() {
        let path = Bundle.main.path(forResource: "vod", ofType: "mp4")!
        if UIVideoEditorController.canEditVideo(atPath: path) {
            let editController = UIVideoEditorController()
            editController.videoPath = path
            editController.delegate = self
            present(editController, animated:true)
        }
    }
}
