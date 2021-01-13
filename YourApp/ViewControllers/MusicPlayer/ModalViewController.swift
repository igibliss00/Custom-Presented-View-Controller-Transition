//
//  RootViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-08.
//

import UIKit

class ModalViewController: UIViewController {
    var dismissButton: DownArrow!
    var tag: Int!
    var stackView: UIStackView!
    var containerView: UIView!
    var titleLabel: UILabel!
    var songDescLabel: UILabel!
    
    init(tag: Int) {
        self.tag = tag
        
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
        if self.traitCollection.userInterfaceIdiom == .phone {
            self.modalPresentationStyle = .custom
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let screenSize = UIScreen.main.bounds.size
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: screenSize.width, height: screenSize.height)))
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
    }
    
    func configureUI() {
        self.dismissButton = DownArrow(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
        self.dismissButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.dismissButton)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.view.addGestureRecognizer(tap)
        
        self.containerView = UIView()
        self.containerView.backgroundColor = .orange
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.containerView)
        let summaryVC = SummaryTableViewController(tag: self.tag)
        addChild(summaryVC)
        summaryVC.view.frame = self.containerView.bounds
        self.containerView.addSubview(summaryVC.view)
        summaryVC.didMove(toParent: self)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // dismissButton
            self.dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            self.dismissButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // containerView
            self.containerView.topAnchor.constraint(equalTo: self.dismissButton.bottomAnchor, constant: 20),
            self.containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ModalViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = LongPressPresentationController(presentedViewController: presented, presenting: presenting)
        return pc
    }
}

extension ModalViewController /*: UIViewControllerTransitioningDelegate*/ {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

// =======
extension ModalViewController {
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
