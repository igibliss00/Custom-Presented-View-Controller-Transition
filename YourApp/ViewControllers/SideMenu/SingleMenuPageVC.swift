//
//  SingleMenuPageVC.swift
//  YourApp
//
//  Created by J C on 2021-01-12.
//

import UIKit

class SingleMenuPageVC: UIViewController {
    var menuData: [MenuData]! 
    init(menuData: [MenuData]) {
        super.init(nibName: nil, bundle: nil)
        self.menuData = menuData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView: UIScrollView!
    var heroView: HeroView!
    var heroView2: HorizontalHeroView!
    var heroView3: HorizontalHeroView!
    var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setConstraints()
        view.tag = 5000
    }
    
    func configureUI() {
        // scroll view
        scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 600)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // hero view 1
        heroView = HeroView(menuData: menuData[0])
        heroView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(heroView)
        
        // hero view 2
        heroView2 = HorizontalHeroView(menuData: menuData[1])
        heroView2.translatesAutoresizingMaskIntoConstraints = false
        
        // hero view 3
        heroView3 = HorizontalHeroView(menuData: menuData[2])
        heroView3.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [heroView2, heroView3])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alpha = 0
        stackView.transform = CGAffineTransform(translationX: 0, y: 80)
        scrollView.addSubview(stackView)
        
        let stackViewAnimation = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.stackView.transform = .identity
            self.stackView.alpha = 1
        }
        stackViewAnimation.startAnimation()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // scroll view
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // hero view
            heroView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            heroView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 10),
            heroView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -10),
            heroView.heightAnchor.constraint(equalToConstant: 150),
            
            // stack view
            stackView.topAnchor.constraint(equalTo: heroView.bottomAnchor, constant: 50),
            stackView.heightAnchor.constraint(equalToConstant: 250),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            
            // hero view 2
            heroView2.widthAnchor.constraint(equalToConstant: 120),
            
            // hero view 3
            heroView3.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}
