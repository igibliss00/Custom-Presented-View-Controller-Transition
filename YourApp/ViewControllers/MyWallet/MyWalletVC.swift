//
//  BillingMasterVC.swift
//  YourApp
//
//  Created by J C on 2021-01-16.
//

import UIKit

class MyWalletVC: UIViewController {
    var scrollView: UIScrollView!
    var heroView: TopHeroView!
    var stackView: UIStackView!
    var toolBarStackView: UIStackView!
    var myWalletOverviewVC: UIViewController!
    
    override func loadView() {
        let v = UIView()
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(topHerViewHandler), name: .TopHeroViewTapped, object: nil)
        
        configureToHeroView()
        configureToolBar()
        configureChildVC()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = myWalletOverviewVC.view.bounds.size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        view.insetsLayoutMarginsFromSafeArea = false
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureToHeroView() {
        // scroll view
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = false
        scrollView.bounces = false
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        scrollView.contentInset = UIEdgeInsets(top: -topPadding, left: 0, bottom: 0, right: 0)
        view.addSubview(scrollView)
        
        // hero view
        heroView = TopHeroView()
        heroView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(heroView)
    }
    
    func configureToolBar() {
        // stack view
        toolBarStackView = UIStackView()
        toolBarStackView.translatesAutoresizingMaskIntoConstraints = false
        toolBarStackView.distribution = .fillEqually
        scrollView.addSubview(toolBarStackView)
        
        // tool bar
        for i in [["systemName": "doc.text.viewfinder", "title": NSLocalizedString("Scan", comment: "")], ["systemName": "barcode.viewfinder", "title": NSLocalizedString("Pay", comment: "")], ["systemName": "wallet.pass", "title": NSLocalizedString("Wallet", comment: "")]] {
            let button = CustomButton(type: .system)
            button.setTitle(i["title"], for: .normal)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            let config = UIImage.SymbolConfiguration(pointSize: 22)
            button.setImage(UIImage(systemName: i["systemName"]!, withConfiguration: config)?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.tintColor = .lightGray
            button.titleLabel?.tintColor = .lightGray
            toolBarStackView.addArrangedSubview(button)
        }
    }
    
    func configureChildVC() {
        myWalletOverviewVC = MyWalletOverviewVC()
        addChild(myWalletOverviewVC)
        scrollView.addSubview(myWalletOverviewVC.view)
        myWalletOverviewVC.view.translatesAutoresizingMaskIntoConstraints = false
        myWalletOverviewVC.didMove(toParent: self)
    }

    // resize the parent vc according to the child vc
    var childVCHeight: CGFloat! = 1000
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if (container as? MyWalletOverviewVC) != nil {
            childVCHeight = container.preferredContentSize.height
        }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // scroll view
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // hero view
            heroView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            heroView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            heroView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            heroView.heightAnchor.constraint(equalToConstant: 300),
            heroView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            // tool bar stack view
            toolBarStackView.topAnchor.constraint(equalTo: heroView.bottomAnchor),
            toolBarStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            toolBarStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            toolBarStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            toolBarStackView.heightAnchor.constraint(equalToConstant: 100),
            
            // child view controller
            myWalletOverviewVC.view.topAnchor.constraint(equalTo: toolBarStackView.bottomAnchor, constant: 50),
            myWalletOverviewVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            myWalletOverviewVC.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            myWalletOverviewVC.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            myWalletOverviewVC.view.heightAnchor.constraint(equalToConstant: childVCHeight)
        ])
    }
    
    @objc func topHerViewHandler() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if case let currentTitle = sender.currentTitle, currentTitle == "Wallet" {
            let walletDetailVC = WalletDetailVC()
            self.navigationController?.pushViewController(walletDetailVC, animated: true)
//            self.present(walletDetailVC, animated: true, completion: nil)
        }
    }
}


//    func createBalanceLabelSeries(text: [String], previous: UIView?) -> (UILabel?, [NSLayoutConstraint]) {
////        guard let previous = previous else { return nil }
//        let previous = previous!
//        balanceLabelArr = [UILabel]()
//        var constraints = [NSLayoutConstraint]()
//        for i in 0...text.count - 1 {
////            let bl = createBalanceLabel(text: text[i])
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.textColor = .white
//            label.text = text[i]
//            balanceMaskView.addSubview(label)
//
//            balanceLabelArr.append(label)
////            guard let index = balanceLabelArr.firstIndex(of: label) else { return nil }
//            let index = balanceLabelArr.firstIndex(of: label)!
//            constraints.append(label.topAnchor.constraint(equalTo: balanceMaskView.topAnchor))
//            constraints.append(label.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/5))
//            if index == 0 {
//                print("prev", previous)
//                constraints.append(label.leadingAnchor.constraint(equalTo: previous.trailingAnchor))
//            } else {
//                constraints.append(label.leadingAnchor.constraint(equalTo: balanceLabelArr[index - 1].trailingAnchor))
//            }
//        }

//        NSLayoutConstraint.activate(constraints)
//        return (balanceLabelArr[balanceLabelArr.count - 1], constraints)
//    }
    
