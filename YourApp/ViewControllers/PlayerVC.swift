//
//  RootViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-08.
//

import UIKit

class PlayerVC: UIViewController {
    var tag: Int!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var image: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet var progressView: UIView!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var panelView: UIStackView!
    @IBOutlet weak var playback: UIView!
    @IBOutlet weak var previous: UIView!
    @IBOutlet weak var nextSong: UIView!
    
    init(tag: Int) {
        super.init(nibName: "PlayerVC", bundle: nil)
        self.tag = tag
        // NB if we want to modify the _animation_, we need to set the transitioningDelegate
        self.transitioningDelegate = self
        if self.traitCollection.userInterfaceIdiom == .phone {
            self.modalPresentationStyle = .automatic
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.playback.addGestureRecognizer(tap)
        
        configureUI()
    }
    
    func configureUI() {
        let playbackButton = Playback(frame: .init(origin: .zero, size: .init(width: self.playback.bounds.width, height: self.playback.bounds.width)))
        self.playback.addSubview(playbackButton)
        
        let nextSongButton = NextSongView(frame: .init(origin: .zero, size: .init(width: self.nextSong.bounds.width - 20, height: self.nextSong.bounds.width - 20)))
        self.nextSong.addSubview(nextSongButton)
        
        let nextSongButton2 = NextSongView(frame: .init(origin: .zero, size: .init(width: self.previous.bounds.width - 20, height: self.previous.bounds.width - 20)))
        nextSongButton2.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.previous.addSubview(nextSongButton2)
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        
    }

    @IBAction func doButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated:true)
    }
}

extension PlayerVC : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = MyPresentationController(presentedViewController: presented, presenting: presenting)
        return pc
    }
}

// ==========================
extension PlayerVC /*: UIViewControllerTransitioningDelegate*/ {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
}

// =======
extension PlayerVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tc = self.transitionCoordinator {
            tc.animate {
                _ in
                //                self.buttonTopConstraint.constant += 200
                //                self.view.layoutIfNeeded()
            }
        }
    }
}
