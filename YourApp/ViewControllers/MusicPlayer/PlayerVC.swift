//
//  RootViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-08.
//

import UIKit

class PlayerVC: UIViewController {
    var tag: Int!
    var isPaused = false
    var imageView: UIImageView!
    var titleView: UIView!
    var progressView: UIProgressView!
    var timerView: UIView!
    var panelStackView: UIStackView!
    var playback: Playback!
    var previous: NextSongView!
    var nextSong: NextSongView!
    var timerLabel = UILabel()

    override func loadView() {
        let screenSize = UIScreen.main.bounds.size
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: screenSize.width, height: screenSize.height)))
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.playback.addGestureRecognizer(tap)
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        self.isPaused = !self.isPaused
        self.playback.isPaused = self.isPaused
        
        let animation = UIViewPropertyAnimator(duration: 30.0, curve: .linear) {
            self.progressView.setProgress(1.0, animated: true)
        }

        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        
        if self.isPaused {
            self.imageView.layer.add(rotation, forKey: "rotationAnimation")
            animation.startAnimation()
        } else {
            self.imageView.layer.removeAllAnimations()
            animation.stopAnimation(true)
        }
    }
    
    func configureUI() {
        self.imageView = UIImageView()
        if let tag = tag, let importedImage = UIImage(named: "\(tag).jpg") {
            let size = CGSize(width: 200, height: 200)
            let bounds = CGRect(origin: .zero, size: size)
            let renderer = UIGraphicsImageRenderer(size: size)
            let image = renderer.image { (_) in
                UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width).addClip()
                importedImage.draw(in: bounds)
            }
            self.imageView.image = image
        }
        self.imageView.contentMode = .scaleAspectFill
        self.view.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
                
        // title view
        self.titleView = UIView()
        let songTitleLabel = UILabel()
        songTitleLabel.text = "Keith Ubran - The Speed of Now"
        self.titleView.addSubview(songTitleLabel)
        self.view.addSubview(self.titleView)
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // progressView
        self.progressView = UIProgressView(progressViewStyle: .default)
        self.view.addSubview(self.progressView)
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        self.progressView.setProgress(0.0, animated: true)
        
        // timerView
        self.timerView = UIView()
        timerLabel.text = ""
        self.timerView.addSubview(timerLabel)
        self.view.addSubview(timerView)
        self.timerView.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // buttons
        let size = CGSize(width: self.view.bounds.size.width / 3, height: self.view.bounds.size.height / 0.25)
        let frame = CGRect(origin: .zero, size: size)
        self.playback = Playback(frame: frame)
        self.previous = NextSongView(frame: frame)
        self.nextSong = NextSongView(frame: frame)
        self.previous.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        // panelStackView
        self.panelStackView = UIStackView(arrangedSubviews: [self.previous, self.playback, self.nextSong])
        self.view.addSubview(self.panelStackView)
        self.panelStackView.translatesAutoresizingMaskIntoConstraints = false
        self.panelStackView.distribution = .fillEqually
        self.panelStackView.alignment = .fill
        self.panelStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            // imageView
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // titleView
            titleView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.50),
            titleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15),
            titleView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            titleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // songTitle
            songTitleLabel.widthAnchor.constraint(equalTo: titleView.widthAnchor),
            songTitleLabel.heightAnchor.constraint(equalTo: titleView.heightAnchor),
            songTitleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            
            // progressView
            progressView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.90),
            progressView.heightAnchor.constraint(equalToConstant: 30),
            progressView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 20),
            progressView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // timerView
            timerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.90),
            timerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.10),
            timerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timerView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20),
            
            // timerLabel
            timerLabel.widthAnchor.constraint(equalTo: timerView.widthAnchor),
            timerLabel.heightAnchor.constraint(equalTo: timerView.heightAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            
            // panelStackView
            panelStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            panelStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            panelStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.90),
            panelStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25),
            panelStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            panelStackView.topAnchor.constraint(lessThanOrEqualTo: timerView.bottomAnchor, constant: 40),
            panelStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}






//// =======
//extension PlayerVC {
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if let tc = self.transitionCoordinator {
//            tc.animate {
//                _ in
//                //                self.buttonTopConstraint.constant += 200
//                //                self.view.layoutIfNeeded()
//            }
//        }
//    }
//}
