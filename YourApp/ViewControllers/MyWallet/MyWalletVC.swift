//
//  BillingMasterVC.swift
//  YourApp
//
//  Created by J C on 2021-01-16.
//

import UIKit

class MyWalletVC: UIViewController {
    var scrollView: UIScrollView!
    var topHeroView: TopHeroView!
    var stackView: UIStackView!
    
    override func loadView() {
        let v = UIView()
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureUI()
        setConstraints()
    }
    
    func configureNavigationBar() {
        // left bar button
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: nil)
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // shadow border
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func configureUI() {
        // scroll view
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 800)
        view.addSubview(scrollView)
        
        // hero view
        topHeroView = TopHeroView()
        topHeroView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(topHeroView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // scroll view
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // hero view
            topHeroView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topHeroView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            topHeroView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            topHeroView.heightAnchor.constraint(equalToConstant: 300),
            
        ])
    }
}

class TopHeroView: UIView {
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .blue
    }
}
